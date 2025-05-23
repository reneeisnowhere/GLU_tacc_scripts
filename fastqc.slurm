#!/bin/bash

#SBATCH -J fastqc-Glu	  	# Job name
#SBATCH -o fastqc-GLU-1.%j		# Name of stdout output file (%j expantds to jobID)
#SBATCH -p vm-small 		# Queue name
#SBATCH -N 1			# Total number of nodes requested
#SBATCH -n 1 			# Total number of mpi tasks requested (normally 1)
#SBATCH -t 06:00:00		# Run time (hh:mm:ss)

# create variables for scratch and work directories
MYSCRATCH=/scratch/09196/reneem/Glucose
MYWORK=/work/09196/reneem/ls6/Glucose

module load tacc-apptainer
module load multiqc



cd "$MYSCRATCH/fastq_files/"

other_dirs=(Ward_Run1113 Ward_Run1144_RepeatRun1113)

for each_dir in "${other_dirs[@]}";do
	echo "Processing directory $each_dir"
	echo "current working directory: $(pwd)"
	echo "looking for: $each_dir/*.gz"
	mkdir -p "$each_dir/fastqc_files"
	apptainer exec "$MYSCRATCH/images/fastqc_0.11.8.sif" fastqc -t 12 -o "$each_dir/fastqc_files" $MYSCRATCH/fastq_files/$each_dir/*.gz
done
echo "Running MultiQC summary..."
multiqc . -o multiqc_summary
echo "$(date) MultiQC done — summary in 'multiqc_summary/'"
echo "$(date) All Done"

#
