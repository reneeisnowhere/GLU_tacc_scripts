#!/bin/bash


#/bamsync_to_scratch.sh
cd /scratch/09196/reneem/Glucose

MAX_JOBS=10

for bam in bam_cat/*bam
do
	while [ "$(squeue -u $USER |wc -l)" -gt "$MAX_JOBS" ]; do
		echo "Waiting for job slots to open..."
		sleep 30
	done

  echo "Submitting $bam"
sbatch scripts/run-featurecounts.sh $bam
#  bash run-featurecounts.sh $bam
#break  # Stop after first file
done
