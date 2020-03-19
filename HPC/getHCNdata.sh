#!/bin/bash
#--------------------------------------------------------------------------------
#  SBATCH CONFIG
#--------------------------------------------------------------------------------
#SBATCH --job-name=getHCNdata			      # name for the job
#SBATCH --cpus-per-task=1             # number of cores
#SBATCH --mem=4G                      # total memory
#SBATCH --time 0-03:00                # time limit in the form days-hours:minutes
#SBATCH --mail-user=jdp6n8@mail.missouri.edu  # email address for notifications
#SBATCH --mail-type=FAIL,END          # email types

#SBATCH --partition General           # max of 1 node and 4 hours; use `Lewis` for larger jobs
#--------------------------------------------------------------------------------

echo "### Starting at: $(date) ###"

## Module Commands
# 'use module avail r/' to find the latest version
module load r/r-3.4.2
module list

## Run the R script
SCRIPT='getHCNdata.R'
srun Rscript ${SCRIPT}

echo "### Ending at: $(date) ###"
