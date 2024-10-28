#!/bin/bash

#SBATCH --job-name="champsim_job_master"
#SBATCH --time=00:15:00
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=3G
#SBATCH --output="champsim_job_master.txt"

echo "Rerunning ChampSim for default configuration on default jobs"

## load modules
ml GCCcore/12.3.0
ml CMake/3.26.3
ml git/2.41.0-nodocs
ml binutils/2.40

echo "================== REBUILDING CHAMPSIM ===================="

set +a
source /scratch/group/llm_research/cpu-llm-optimization/main-cpu-llm-optimization/.env
set -a

CALLED_DIR=$(pwd)  # Use lowercase 'pwd'
echo "Called Directory: $CALLED_DIR"

echo "ChampSim Directory: $CHAMPSIM"
cd "$CHAMPSIM" || { echo "Failed to change directory to $CHAMPSIM"; exit 1; }
./config.sh "$CALLED_DIR"/*.json
make || { echo "Make failed!"; exit 1; }  # Check if make succeeds

cd "$CALLED_DIR" || { echo "Failed to return to directory $CALLED_DIR"; exit 1; }

echo "=============== FINISHED BUILDING CHAMPSIM ================"
echo

echo "=============== SUBMITTING JOBS ==================="

for job in *.slurm; do
    echo "Submitting $job"
    sbatch "$job"

    if [ $? -eq 0 ]; then
        echo "$job submitted successfully."
    else
        echo "Failed to submit $job."
    fi
done

