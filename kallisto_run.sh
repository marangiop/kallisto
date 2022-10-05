#!/bin/bash
#$ -cwd
#fill with flags for qsub as -q or -l if required

#activate the conda kallisto environment
conda activate kallisto

#set the current job directory
dir=

#command for job array
cmd="$(sed -n ${SGE_TASK_ID}p $dir/job.txt)"

#launch command
${cmd} 
