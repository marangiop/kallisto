#script for generate the list with paired end, input for kallisto_quant.sh

#libraries
import os

#directory for the fastq input
path = os.getcwd()
dir = path+"/sample_input"

#final list
list = open("input_file_list.txt",'w')

#create the list
sample_list = []
for sample in os.listdir(dir):
   sample = sample.split('_')[0]
   if sample not in sample_list:
      sample_list.append(sample)

#write the input file for the parallel job
for sample_name in sample_list:
   R1 = dir+"/"+sample_name+"_R1.fastq.gz"
   R2 = dir+"/"+sample_name+"_R2.fastq.gz"
   line = sample_name+"\t"+R1+"\t"+R2+"\n"
   list.write(line)
list.close()
