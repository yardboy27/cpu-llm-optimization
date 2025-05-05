#!/bin/bash
#SBATCH --job-name=test_job
#SBATCH --ntasks=1
#SBATCH --mem=16GB
#SBATCH --time=10:00
#SBATCH --output=test_output.txt
echo "Hello, SLURM!"

