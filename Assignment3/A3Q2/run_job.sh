#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --job-name="a3"
#SBATCH --output=%j.stdout
#SBATCH --mail-user=kavithae@buffalo.edu
#SBATCH --mail-type=all
#SBATCH --account=cse470
#SBATCH --partition=scavenger
#SBATCH --qos=scavenger
#SBATCH --cluster=faculty
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --exclusive

echo "LETS START THE TEST CASES"

echo "NODE DETAILS"
echo "JOB_ID=$SLURM_JOB_ID"
echo "hostname=`hostname`"
echo "ARCH=$CCR_ARCH"
date -u

lscpu
nvidia-smi

module load cuda

echo "++++ n=500 GPU h=0.5 ++++"
./a3_cuda 500 0.5
echo "++++ n=500 h=0.5 ++++"
./a3_seq 500 0.5
echo "++++ n=10000 GPU h=0.5 ++++"
./a3_cuda 10000 0.5
echo "++++ n=10000 h=0.5 ++++"
./a3_seq 10000 0.5
echo "++++ n=20000 GPU h=0.5 ++++"
./a3_cuda 20000 0.5
echo "++++ n=20000 h=0.5 ++++"
./a3_seq 20000 0.5
echo "++++ n=50000 GPU h=0.5 ++++"
./a3_cuda 50000 0.5
echo "++++ n=50000 h=0.5 ++++"
./a3_seq 50000 0.5
echo "++++ n=80000 GPU h=0.5 ++++"
./a3_cuda 80000 0.5
echo "++++ n=80000 h=0.5 ++++"
./a3_seq 80000 0.5
echo "++++ n=100000 GPU h=0.5 ++++"
./a3_cuda 100000 0.5
echo "++++ n=100000 h=0.5 ++++"
./a3_seq 100000 0.5
echo "++++ n=400000 GPU h=0.5 ++++"
./a3_cuda 400000 0.5
echo "++++ n=400000 h=0.5 ++++"
./a3_seq 400000 0.5
echo "++++ n=500000 GPU h=0.5 ++++"
./a3_cuda 500000 0.5
echo "++++ n=500000 h=0.5 ++++"
./a3_seq 500000 0.5
echo "++++ n=1000000 GPU h=0.5 ++++"
./a3_cuda 1000000 0.5
echo "++++ n=1000000 h=0.5 ++++"
./a3_seq 1000000 0.5

echo "=========================== THE END =================================="

