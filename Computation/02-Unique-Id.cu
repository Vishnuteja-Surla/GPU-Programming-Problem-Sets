/*
Write a program to find out the unique id of each thread irrespective of what kernel
launch configuration is used (that is, single / multiple blocks, number of dimensions of
threads / blocks, etc.).
*/
#include<cuda.h>
#include<stdio.h>

__global__ void findUniqueID(){
    unsigned noOfthreadsPerBlock = blockDim.x * blockDim.y * blockDim.z;
    
    int uniqueId = 0;

    // Locating Block Id
    uniqueId += gridDim.x * gridDim.y * blockIdx.z * noOfthreadsPerBlock;
    uniqueId += gridDim.x * blockIdx.y * noOfthreadsPerBlock;
    uniqueId += blockIdx.x * noOfthreadsPerBlock;

    // Locating Thread Id inside block
    uniqueId += blockDim.x * blockDim.y * threadIdx.z;
    uniqueId += blockDim.x * threadIdx.y;
    uniqueId += threadIdx.x;

    // Print Id
    printf("Block (%d, %d, %d) - Thread (%d, %d, %d) : %d\n", blockIdx.x, blockIdx.y, blockIdx.z, threadIdx.x, threadIdx.y, threadIdx.z, uniqueId);
}

int main(){
    dim3 grid(1, 2, 2);
    dim3 block(3, 1, 2);
    findUniqueID<<<grid, block>>>();
    cudaDeviceSynchronize();
    return 0;
}