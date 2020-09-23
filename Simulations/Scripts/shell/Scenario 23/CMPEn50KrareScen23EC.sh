#!/bin/bash
#SBATCH -n 1                    # Number of cores requested
#SBATCH -t 5:00:00                    # Runtime in minutes
                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
#SBATCH -p short                # Partition (queue) to submit to
#SBATCH --mem-per-cpu=8G        # 8 GB memory needed (memory PER CORE)
#SBATCH --open-mode=append      # append adds to outfile, truncate deletes first
### In filenames, %j=jobid, %a=index in job array
#SBATCH -o CMPEn50KrareScen23EC.R.out               # Standard out goes to this file
#SBATCH -e CMPEn50KrareScen23EC.R.err               # Standard err goes to this file
#SBATCH --mail-type=END         # Mail when the job ends  
#write command-line commands below this line
module load gcc/6.2.0 R/3.5.1
Rscript CMPEn50KrareScen23EC.R