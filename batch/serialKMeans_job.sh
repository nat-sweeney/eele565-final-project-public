#!/bin/bash
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
## Basic parameters
##
#SBATCH --account=priority-bradwhitaker     # specify the account to use if using a priority partition
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --cpus-per-task=65              # number of cores to allocate
#SBATCH --mem=65G                      # ammount of Memory allocated
#SBATCH --time=0-24:00:00               # maximum job run time in days-hours:minutes:secconds
#SBATCH --job-name=serialKMeans   # job name

##
## Optional parameters - remove one leading hashtag to enable
##
#SBATCH --nodes=1                      # number of nodes to allocate for multinode job
##SBATCH --ntasks-per-node=1            # number of descrete tasks to allocate for MPI job
##SBATCH --gpus-per-task=1              # number of GPUs to allocate for GPU job
## Run 'man sbatch' for more information on the options above.
## Below, enter commands needed to execute your workload

#SBATCH --output=skmResults.out        # standard output from job
#SBATCH --error=skmResults.err        # standard error from job
##SBATCH --nodelist=tempest-epyc021

cd /home/b16q989/grad-school/parallel-processing/final-project/preprocessing
module load math/matlab

matlab preprocessData.m

cd ../serial
module load Julia

export OPENBLAS_NUM_THREADS=1
julia smallSerialKMeans.jl
julia mediumSerialKMeans.jl
julia largeSerialKMeans.jl
julia fullSerialKMeans.jl