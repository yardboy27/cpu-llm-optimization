#!/bin/bash
#SBATCH --job-name=champsim_trace_array
#SBATCH --array=0-1  # Assuming 10 traces
#SBATCH --time=07-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=32GB
#SBATCH --partition=xlong

# Output and error files will now be dynamically placed in the ChampSim output directory
#SBATCH --output="%x_%A_%a_output.txt"
#SBATCH --error="%x_%A_%a_error.txt"

# Load environment and modules
set -a
source ./../../../.env
set +a

ml GCCcore/12.3.0
ml CMake/3.26.3
ml git/2.41.0-nodocs
ml binutils/2.40
ml Python/3.11.3

# Store the current directory
SLURM_FULL_PATH=$(pwd)
SLURM_DIRECTORY=$(basename $(pwd))

# Get the list of traces
TRACE_DIR="$TRACES/test"

# Check if TRACES directory exists
if [ ! -d "$TRACE_DIR" ]; then
    echo "Error: TRACES directory $TRACE_DIR does not exist."
    exit 1
fi

traces=( $(ls $TRACE_DIR/*.xz) )

# Run for the trace corresponding to this task
TRACE_FILE=${traces[$SLURM_ARRAY_TASK_ID]}

# Check if OUTPUT_ROOT exists
if [ ! -d "$OUTPUT_ROOT" ]; then
    echo "Error: OUTPUT_ROOT directory $OUTPUT_ROOT does not exist."
    exit 1
fi

# Create the output directory for this task
# OUTPUT_DIR="$OUTPUT_ROOT/champsim_results_${SLURM_ARRAY_TASK_ID}"
OUTPUT_DIR="$OUTPUT_ROOT/$SLURM_DIRECTORY-j$SLURM_JOB_ID"

## Create the output directory if it doesn't exist
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "OUTPUT_DIR $OUTPUT_DIR did not exist. Creating $OUTPUT_DIR now."
    mkdir -p "$OUTPUT_DIR"
fi

# benchmark variable is configured for our trace file names
benchmark=$(basename $TRACE_FILE .champsimtrace.xz)  # Extracts the benchmark name

# Redirect SLURM output and error to this output directory

#SBATCH --output="$OUTPUT_DIR/${benchmark}-std_output.txt"
#SBATCH --error="$OUTPUT_DIR/${benchmark}-error.txt"

# Define the output file for ChampSim execution
CHAMPSIM_OUTPUT_FILE="$OUTPUT_DIR/${benchmark}-champsim_output-j${SLURM_JOB_ID}.txt"

# Run ChampSim with the specific trace
stdbuf -oL $CHAMPSIM_BIN --warmup-instructions 0 --simulation-instructions 1000000000000 $TRACE_FILE > $CHAMPSIM_OUTPUT_FILE

