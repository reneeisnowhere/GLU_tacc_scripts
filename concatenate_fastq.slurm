#!/bin/bash

#SBATCH -J concatenate	  	# Job name
#SBATCH -o cat_Glu.%j		# Name of stdout output file (%j expantds to jobID)
#SBATCH -p vm-small 		# Queue name
#SBATCH -N 1			# Total number of nodes requested
#SBATCH -n 1 			# Total number of mpi tasks requested (normally 1)
#SBATCH -t 06:00:00		# Run time (hh:mm:ss)

# create variables for scratch and work directories
MYSCRATCH=/scratch/09196/reneem/Glucose
MYWORK=/work/09196/reneem/ls6/Glucose

#module load tacc-apptainer
#module load multiqc



cd "$MYSCRATCH/fastq_files/"
mkdir -p merged_fastq

for file in Ward_Run1113/*fastq.gz;do
	filename=$(basename "$file");
	cat "Ward_Run1113/$filename" "Ward_Run1144_RepeatRun1113/$filename"> "merged_fastq/$filename";
done
echo "$(date) All Done"

#
