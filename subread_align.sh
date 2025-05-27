#!/bin/bash

#SBATCH -J align-Glu	  	# Job name
#SBATCH -o align-GLU-1.%j		# Name of stdout output file (%j expantds to jobID)
#SBATCH -p normal 		# Queue name
#SBATCH -N 1			# Total number of nodes requested
#SBATCH -n 1 			# Total number of mpi tasks requested (normally 1)
#SBATCH -t 21:00:00		# Run time (hh:mm:ss)

# create variables for scratch and work directories
MYSCRATCH=/scratch/09196/reneem/Glucose
MYWORK=/work/09196/reneem/ls6/Glucose

module purge
module load intel/19.1.1
module load impi/19.0.9
module load Rstats/4.0.3





cd "$MYSCRATCH"
#cp /scratch/09196/reneem/Glucose/samplesheet.txt .


echo $(date)
for i in $(cat samplesheet.txt); do
	read1=fastq_files/merged_fastq/${i}_R1.fastq.gz;
	read2=fastq_files/merged_fastq/${i}_R2.fastq.gz;
	Rscript scripts/subread_align.R $read1 $read2;
done
echo "$(date) All Done"

#
