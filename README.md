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

this step will allow you to create a conda environment from which you can use the kallisto software, using the following command from the base directory:
```
conda env create --name kallisto --file kallisto_environment.yaml
```

