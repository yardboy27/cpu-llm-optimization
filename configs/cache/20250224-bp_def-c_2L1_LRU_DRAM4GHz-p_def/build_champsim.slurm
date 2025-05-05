#!/bin/bash
#SBATCH --job-name=champsim_build
#SBATCH --time=00:45:00  # Adjust time for build
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=16GB

# Load environment and modules
set -a
source ./../../../.env
set +a

ml GCCcore/12.3.0
ml CMake/3.26.3
ml git/2.41.0-nodocs
ml binutils/2.40
ml Python/3.11.3

# save the slurm directory to access the config file
SLURM_FULL_PATH=$(pwd)
SLURM_DIRECTORY=$(basename $(pwd))

# Locate the first .json file in the slurm directory
CONFIG_FILE=$(find "$SLURM_FULL_PATH" -maxdepth 1 -name "*.json" | head -n 1)

if [[ -z $CONFIG_FILE ]]; then
  echo "No .json file found in the slurm directory."
  exit 1
fi

echo "Attempting to build ChampSim with config file: $CONFIG_FILE"
echo "==========================================================="

# Build ChampSim
cd "$CHAMPSIM"
./config.sh --bindir="$CHAMPSIM_BIN_DIR" "$CONFIG_FILE"
make || { echo "Build failed"; exit 1; }


echo "==========================================================="
echo "ChampSim build completed successfully."

