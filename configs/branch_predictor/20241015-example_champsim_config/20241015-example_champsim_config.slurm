#!/bin/bash

## SLURM Settings
#SBATCH --job-name=champsim_llm2
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=32768M
#SBATCH --partition=long
#SBATCH --mail-type=ALL
#SBATCH --mail-user=baileyfaulk2003@tamu.edu

## Load .env file paths; includes: $PROJECT_ROOT, $CHAMPSIM, $CHAMPSIM_BIN, $OUTPUT_ROOT
set -a
source ./../../../.env
set +a

## File and Reference constants
CURRENT_DIR=$(basename "$PWD")                   # directory we are currently in
OUTPUT_DIR=$OUTPUT_ROOT/$CURRENT_DIR"-results-j$SLURM_JOB_ID"   # folder for the run we are about to have

## Create the output directory if it doesn't exist
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "OUTPUT_DIR $OUTPUT_DIR did not exist. Creating $OUTPUT_DIR now." 
    mkdir -p "$OUTPUT_DIR"
fi

## Create output file names
CHAMPSIM_OUTPUT_FILE=$OUTPUT_DIR/$CURRENT_DIR"-champsim_output.txt"
STDOUT_FILE=$OUTPUT_DIR/$CURRENT_DIR"-stdout_log.txt"
ERROR_LOG_FILE=$OUTPUT_DIR/$CURRENT_DIR"-error_log.txt"

## Redirect stdout and stderr to their respective files
exec > >(tee -a $STDOUT_FILE) 2> $ERROR_LOG_FILE

## Load modules 
ml GCCcore/12.3.0
ml CMake/3.26.3
ml git/2.41.0-nodocs
ml binutils/2.40
ml Python/3.11.3

## Prep Env and Build ChampSim executable
cd $CHAMPSIM
./config.sh champsim_config.json

cd $OUTPUT_DIR

## Ensure $TRACES variable is set and points to the correct directory
# if [ -z "$TRACES" ]; then
#    echo "Error: TRACES environment variable is not set."
#    exit 1
# fi

# cd $TRACES

## Set up simulation parameters
export TARGET_PROG=$RESEARCH_ROOT/benchmarks/605.mcf_s-665B.champsimtrace.xz
export WARMUP_INSTRS=0
export SIMULATION_INSTRS=10000000000

## Run
echo "-------------------------RUNNING CHAMPSIM WITH FOLLOWING COMMAND------------------------"
echo "stdbuf -oL $CHAMPSIM_BIN --warmup_instructions $WARMUP_INSTRS --simulation_instructions $SIMULATION_INSTRS $TARGET_PROG > $CHAMPSIM_OUTPUT_FILE"
echo
stdbuf -oL $CHAMPSIM_BIN --warmup-instructions $WARMUP_INSTRS --simulation-instructions $SIMULATION_INSTRS $TARGET_PROG > $CHAMPSIM_OUTPUT_FILE

## Clean Up
