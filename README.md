# kallisto abundance for paired-end reads samples

The repository script and the execution of the steps mentioned below in the correct order, will allow to obtain the transcript quantification and BAM files for different samples of a specific organism, using the Kallisto software.

## 1 - sample_input files

The process requires the fastq files of both reads for each sample, which must be saved in the **sample_input** folder as follows:
```
samplename_R1.fastq.gz
samplename_R2.fastq.gz
```

## 2 - genome_input files

The folder must contain some essential files referring to the genome under consideration:

### chromosomes.tsv

Is a tab separated file with chromosome names and lengths, an example of this file can be found in the following path:
```
Analysis/input/chromosomes.tsv 
```

### kallisto.gtf

The Kallisto software requires a gtf file with a specific order, to convert a normal gtf just follow the steps below:
```
awk '( $3 ~ /gene/ )' old.gtf > kallisto.gtf
awk '( $3 ~ /transcript/ )' old.gtf >> kallisto.gtf
awk '( $3 ~ /exon/ && $7 ~ /+/ )' old.gtf | sort -k1.10,1.11n -k4,4n >> kallisto.gtf 
awk '( $3 ~ /exon/ && $7 ~ /-/ )' old.gtf | sort -k1.10,1.11n -k4,4nr >> kallisto.gtf
```
An example of this file can be found in the following path:
```
Analysis/input/kallisto.gtf
```

### transcripts.fa

This file must contain the transcripts in the fasta format, an example of this file can be found in the path:
```
Analysis/input/transcript.fa
```

## 3 - Create the conda environment from the kallisto_environment.yaml

This step will allow you to create and run a conda environment from which you can use the kallisto software and parallel to run multiple jobs, using the following command from the base directory:
```
conda create --name kallisto kallisto==0.48.0
conda activate kallisto
```

## 4 - Generate the file list

The creation of the file input_file_list.txt, will allow you to have a list of all the files in the sample_input folder, making them accessible to Kallisto
```
python3 generate_list.py
```

## 5 - Generate the Kallisto index

The Kallisto software requests an index obtained from the transcript.fa, by running the following command:
```
kallisto index --index=genome_input/kallisto_index genome_input/transcripts.fa
```

## 6 - generate the job.txt

The generation of this file will allow to run the kallisto software on the indicated samples in parallel:
```
./kallisto_make_job.sh input_file_list.txt job.txt
```

## 7 - kallisto quantification run

Once the following steps have been carried out it will be possible to perform quantitation using the kallisto software by executing the following command,

IMPORTANT fill the script kallisto_run.sh with qsub flags (if required) and with the directory in wich job.txt is stored.
```
qsub -t 1-{num_of_jobs} path/kallisto_run.sh
```
IMPORTANT replace {num_of_jobs} with your effective number of jobs and path with the same path used in the kallisto_run.sh.

The process will save the Kallisto output in the kallisto_output folder, divided into subfolders for each sample taken into consideration. As well as the kallisto_joblog.txt file in the main folder, which will allow you to check the status of the processes performed.

## Citation

Bray, N. L., Pimentel, H., Melsted, P. & Pachter, L.
Near-optimal probabilistic RNA-seq quantification, 
Nature Biotechnology 34, 525-527(2016), doi:10.1038/nbt.3519

Tange, O. (2022, September 22). GNU Parallel 20220922 ('Elizabeth').
Zenodo. https://doi.org/10.5281/zenodo.7105792
