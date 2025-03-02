#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --job-name="a1"
#SBATCH --output=%j.stdout
#SBATCH --mail-user=kavithae@buffalo.edu
#SBATCH --mail-type=all
#SBATCH --account=cse470
#SBATCH --partition=scavenger
#SBATCH --qos=scavenger
#SBATCH --cluster=faculty
#SBATCH --constraint=CPU-Gold-6330,AVX512
#SBATCH --exclusive

echo "LETS START THE TEST CASES"

echo "NODE DETAILS"
echo "JOB_ID=$SLURM_JOB_ID"
echo "hostname=`hostname`"
echo "ARCH=$CCR_ARCH"
date -u

lscpu

echo "=========================== Test Case 1 =================================="
n=(10000 40000 160000 640000 2560000 10240000)
p=(1 2 4 8 16 32)

for i in "${n[@]}"; do
	for j in "${p[@]}"; do
		echo "++++ n=${i} p=${j} ++++"
		OMP_NUM_THREADS=${j} ./a1 ${i} ${i}
	done
done

echo "=========================== Test Case 2 =================================="
n=(100 400 1600 6400 25600 102400)
p=(1 2 4 8 16 32)

for i in "${n[@]}"; do
	for j in "${p[@]}"; do
		echo "++++ n=${i} p=${j} ++++"
		OMP_NUM_THREADS=${j} ./a1 ${i} ${i}
	done
done

echo "=========================== Test Case 3 =================================="
n=(1000 4000 16000 64000 256000 1024000)
p=(1 2 4 8 16 32)

for i in "${n[@]}"; do
	for j in "${p[@]}"; do
		echo "++++ n=${i} p=${j} ++++"
		OMP_NUM_THREADS=${j} ./a1 ${i} ${i}
	done
done

echo "=========================== THE END =================================="
