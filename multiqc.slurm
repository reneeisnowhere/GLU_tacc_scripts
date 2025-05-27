#!/bin/bash

#SBATCH -J multiqc-Glu	  	# Job name
#SBATCH -o multiqc-GLU-1.%j		# Name of stdout output file (%j expantds to jobID)
#SBATCH -p vm-small 		# Queue name
#SBATCH -N 1			# Total number of nodes requested
#SBATCH -n 1 			# Total number of mpi tasks requested (normally 1)
#SBATCH -t 01:00:00		# Run time (hh:mm:ss)

# create variables for scratch and work directories
MYSCRATCH=/scratch/09196/reneem/Glucose
MYWORK=/work/09196/reneem/ls6/Glucose
module unload xalt
module load tacc-apptainer
module load multiqc



cd "$MYSCRATCH/fastq_files"

other_dirs=(merged_fastq)

for each_dir in "${other_dirs[@]}";do

	mkdir -p "$each_dir/fastqc_files"
	mkdir -p "$each_dir/fastqc_files/multiqc_summary"
	echo "Running MultiQC summary..."
	multiqc "$each_dir/fastqc_files" -o "$each_dir/fastqc_files/multiqc_summary"
echo "$(date) MultiQC done — summary in 'multiqc_summary/'"
done

echo "$(date) All Done"

#
