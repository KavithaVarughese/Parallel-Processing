#!/bin/bash -l

#SBATCH --job-name="a2"
#SBATCH --output=%j.stdout
#SBATCH --mail-user=kavithae@buffalo.edu
#SBATCH --mail-type=all
#SBATCH --account=cse470
#SBATCH --partition=scavenger
#SBATCH --qos=scavenger
#SBATCH --cluster=faculty
#SBATCH --constraint=CPU-Gold-6126,AVX512
#SBATCH --exclusive

####### Get --ntasks-per-node --nodes --ntasks from SBATCH


echo "LETS START THE TEST CASES"

echo "NODE DETAILS"
echo "JOB_ID=$SLURM_JOB_ID"
echo "NUMBER OF TASKS PER NODE=$SLURM_TASKS_PER_NODE"
echo "hostname=`hostname`"
echo "ARCH=$CCR_ARCH"
date -u

module load intel

echo "=========================== Test Case 1 =================================="

n=(10000000 160000000 320000000 640000000 1280000000)

for i in "${n[@]}"; do
	echo "++++ n=${i} ++++"
	mpiexec -n $SLURM_TASKS_PER_NODE ./a2 ${i}
done

echo "=========================== Test Case 2 =================================="

n=(5000 80000 160000 320000 640000)

for i in "${n[@]}"; do
	echo "++++ n=${i} ++++"
	mpiexec -n $SLURM_TASKS_PER_NODE ./a2 ${i}
done

echo "=========================== Test Case 3 =================================="

n=(20000 320000 640000 320000 640000)

for i in "${n[@]}"; do
	echo "++++ n=${i} ++++"
	mpiexec -n $SLURM_TASKS_PER_NODE ./a2 ${i}
done

echo "=========================== Test Case 3 =================================="

n=(400 6400 12800 25600 51200)

for i in "${n[@]}"; do
	echo "++++ n=${i} ++++"
	mpiexec -n $SLURM_TASKS_PER_NODE ./a2 ${i}
done

echo "=========================== THE END =================================="
