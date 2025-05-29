#!/bin/bash

#SBATCH -J featurecounts	  	# Job name
#SBATCH -o countsfeat.%j		# Name of stdout output file (%j expantds to jobID)
#SBATCH -p vm-small 		# Queue name
#SBATCH -N 1			# Total number of nodes requested
#SBATCH -n 1 			# Total number of mpi tasks requested (normally 1)
#SBATCH -t 01:00:00		# Run time (hh:mm:ss)

# create variables for scratch and work directories
MYSCRATCH=/scratch/09196/reneem/
#MYWORK=/work/09196/reneem/ls6/

# command line argument

module purge
module load intel/19.1.1
module load impi/19.0.9
module load Rstats/4.0.3


bam="$1"




cd $MYSCRATCH/Glucose

# copy the script
#cp ~/run-featurecounts.R .

echo $(date) "Running Rscript run-featurecounts.R $bam"

time Rscript scripts/run-featurecounts.R $bam


echo $(date) "Done"

