#script for generate the list with paired end, input for kallisto_quant.sh

#libraries
import os

#directory
dir = "/users/rg/gasole/DEG/sample_collapsed"

#final list
list = open("input_file_list.txt",'w')

#create the list
for sample in os.listdir(dir):
   sample_name = sample[:3]
   R1 = dir+"/"+sample_name+"/merge_R1.fastq.gz"
   R2 = dir+"/"+sample_name+"/merge_R2.fastq.gz"
   line = sample_name+"\t"+R1+"\t"+R2+"\n"
   list.write(line)
list.close()
