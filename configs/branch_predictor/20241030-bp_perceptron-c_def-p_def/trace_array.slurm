#!/bin/bash
#SBATCH --job-name=champsim_trace_array
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=32GB
#SBATCH --partition=xlong
#SBATCH --dependency=afterok:<BUILD_JOB_ID>  # Dependency on build job

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
SLURM_DIRECTORY=$(basename "$SLURM_FULL_PATH")

# Define the trace directory
# TODO: make the trace directory be passed into by the .sh file
# TRACE_DIR="$TRACES/test"

# Check if the TRACES directory exists --> passed in from the .sh file that calls this
if [ ! -d "$TRACE_DIR" ]; then
    echo "Error: TRACES directory $TRACE_DIR does not exist."
    exit 1
fi

# Get the list of traces
traces=( $(ls "$TRACE_DIR"/*.xz) )

# Run for the trace corresponding to this task
TRACE_FILE=${traces[$SLURM_ARRAY_TASK_ID]}

# Check if OUTPUT_ROOT exists
if [ ! -d "$OUTPUT_ROOT" ]; then
    echo "Error: OUTPUT_ROOT directory $OUTPUT_ROOT does not exist."
    exit 1
fi

# Create the output directory for this task
OUTPUT_DIR="$OUTPUT_ROOT/$SLURM_DIRECTORY-d$BUILD_JOB_DATE"

# Create the output directory if it doesn't exist
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "OUTPUT_DIR $OUTPUT_DIR did not exist. Creating $OUTPUT_DIR now."
    mkdir -p "$OUTPUT_DIR"
fi

# Benchmark variable is configured for our trace file names
benchmark=$(basename "$TRACE_FILE" .champsimtrace.xz)  # Extracts the benchmark name

# Define output and error files for ChampSim execution
CHAMPSIM_OUTPUT_FILE="$OUTPUT_DIR/${benchmark}-champsim_output.txt"
CHAMPSIM_STD_OUTPUT="$OUTPUT_DIR/${benchmark}-std_output.txt"
CHAMPSIM_ERROR_FILE="$OUTPUT_DIR/${benchmark}-error.txt"

# Redirect output and error
exec > "$CHAMPSIM_STD_OUTPUT"
exec 2> "$CHAMPSIM_ERROR_FILE"

# Run ChampSim with the specific trace
stdbuf -oL $CHAMPSIM_BIN --warmup-instructions 0 "$TRACE_FILE" > "$CHAMPSIM_OUTPUT_FILE"

