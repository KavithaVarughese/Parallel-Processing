#include <iostream>
#include <vector>
#include <cuda.h> 
#include <cuda_runtime.h>
#include <cmath>
#include "a3.hpp"

/*
    Assuming that the host has atleast 1 gpu. 
    Return the maximum number of threads in a block of device 0
*/
int get_block_size() {
    cudaDeviceProp deviceProp;
    cudaGetDeviceProperties(&deviceProp, 0);
    return deviceProp.maxThreadsPerBlock;
}

__global__ void gaussian_kde_kernel(int n, float h, const float *x, float *y) {
    extern __shared__ float sdata[];

    int gidx = blockIdx.x * blockDim.x + threadIdx.x;
    int lidx = threadIdx.x;
    float sum = 0.0;

    for (int i = 0; i < gridDim.x; i++) {
        // save blockwise data into the shared memory in each iteration
        if ((lidx + i * blockDim.x) < n )
            sdata[lidx] = x[(lidx + i * blockDim.x)];

        // sync threads before computation
        __syncthreads();

        /*
            To compute y[k], take x[k] from global memory. 
            Calculate the cummulative sum of elements till the block reached in this iteration
        */
        if (gidx < n) {
            int j = 0;
            while ((j < blockDim.x) && ((j + i * blockDim.x) < n)) {
                float diff = (x[gidx] - sdata[j]) / h;
                sum += (expf(-0.5 * diff * diff) / (sqrtf(2.0 * M_PI)));
                j++;
            }
            
        }

        // Sync threads before overriding values of next block into shared memory.
        __syncthreads();
    }

    y[gidx] = sum / (n * h);

}

void gaussian_kde(int n, float h, const std::vector<float>& x, std::vector<float>& y) {

    // Determine block and grid size
    int blockSize = get_block_size();
    int numBlocks = ( n + blockSize - 1 ) / blockSize;

    // Allocate and Load Memory
    float *d_x, *d_y;
    cudaMalloc(&d_x, n * sizeof(float));
    cudaMalloc(&d_y, n * sizeof(float));
    cudaMemcpy(d_x, x.data(), n * sizeof(float), cudaMemcpyHostToDevice);

    /*
        Shared memory space = blockSize * sizeof(float)
        Copying the entire array of size n to shared memory is insane
    */
    gaussian_kde_kernel<<<numBlocks, blockSize, blockSize * sizeof(float)>>>(n, h, d_x, d_y);

    // Load result back to y
    cudaMemcpy(y.data(), d_y, n * sizeof(float), cudaMemcpyDeviceToHost);

    // Free memory
    cudaFree(d_x);
    cudaFree(d_y);
}