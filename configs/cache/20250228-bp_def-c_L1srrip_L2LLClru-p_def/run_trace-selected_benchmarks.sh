set -a
source ./../../../.env
set +a


export BUILD_JOB_DATE=$(date +"%Y%m%d%H%M%S")

# Store the current directory
SLURM_DIRECTORY=$(basename $(pwd))
export CHAMPSIM_BIN_DIR="$CHAMPSIM/bin/$SLURM_DIRECTORY-d$(date +"%Y%m%d%H%M%S")"
mkdir -p $CHAMPSIM_BIN_DIR

export BUILD_JOB_ID=$(sbatch --parsable --mail-type=$MAIL_TYPE --mail-user=$MAIL_USER build_champsim.slurm)

echo "i got here"
export CHAMPSIM_BIN="$CHAMPSIM_BIN_DIR/champsim"
export TRACE_DIR=$TRACES/selected_benchmarks

sleep 15 

sbatch --dependency=afterok:$BUILD_JOB_ID --array=0-3 --mail-type=$MAIL_TYPE --mail-user=$MAIL_USER trace_array.slurm
