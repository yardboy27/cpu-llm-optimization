set -a
source ./../../../.env
set +a

export BUILD_JOB_ID=$(sbatch --parsable --mail-type=$MAIL_TYPE --mail-user=$MAIL_USER build_champsim.slurm)
export BUILD_JOB_DATE=$(date +"%Y-%m-%d_%H:%M:%S")

export TRACE_DIR=$TRACES/selected_benchmarks
sbatch --dependency=afterok:$BUILD_JOB_ID --array=0-3 --mail-type=$MAIL_TYPE --mail-user=$MAIL_USER trace_array.slurm
