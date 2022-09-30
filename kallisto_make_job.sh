#!/bin/bash

[ $# -ne 2 ] && { echo -en "\n*** This script generates jobs for GNU parallel. *** \n\n Error Nothing to do, usage: < input tab delimited list > < output run list file >\n\n" ; exit 1; }
set -o pipefail

# Get command-line args
INPUT_LIST=$1
OUTPUT=$2
INDEX="$(pwd)/genome_input/kallisto_index"
CHR="$(pwd)/genome_input/chromosomes.tsv"
GTF="$(pwd)/genome_input/kallisto.gtf"

# Set counter
COUNT=1
END=$(wc -l $INPUT_LIST | awk '{print $1}')

echo " "
echo " * Input file is: $INPUT_LIST"
echo " * Number of runs: $END"
echo " * Output job list for GNU parallel saved to: $OUTPUT"
echo " "

# Main bit of command-line for job
CMD="kallisto quant -i $INDEX --genomebam --rf-stranded --bias -c $CHR --gtf $GTF"

# Main Loop
[ -e $OUTPUT ] && rm $OUTPUT
while [ $COUNT -le $END ];
do
    LINE=( $(awk "NR==$COUNT" $INPUT_LIST) )
    # Make file list
    echo "Working on $COUNT of $END Sample ID: ${LINE[0]}, Files ${LINE[@]:1}"
    echo "$CMD -o $(pwd)/kallisto_output/${LINE[0]} ${LINE[@]:1}" >> $OUTPUT
    ((COUNT++))
done

