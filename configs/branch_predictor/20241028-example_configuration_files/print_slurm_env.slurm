#!/bin/bash

## SLURM Settings
#SBATCH --job-name=print_sbatch_env
#SBATCH --time=00-00:00:05
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=32768M
#SBATCH --partition=xlong
#SBATCH --output=print_slurm_env.txt

env | grep SLURM

## Clean Up
