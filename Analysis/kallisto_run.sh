#!/bin/bash

#import modules
conda activate Kallisto

parallel --progress --jobs 8 --joblog kallisto_joblog.txt < /users/rg/gasole/DEG/kallisto_quant/job.txt
