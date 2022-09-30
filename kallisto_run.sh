#!/bin/bash

#import modules
conda activate Kallisto

parallel --progress --jobs 8 --joblog kallisto_joblog.txt < $(pwd)/job.txt
