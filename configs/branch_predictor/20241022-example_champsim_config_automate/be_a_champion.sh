export BUILD_JOB_ID=$(sbatch --parsable build_champsim.slurm)
sbatch --dependency=afterok:$BUILD_JOB_ID run_trace_array.slurm
