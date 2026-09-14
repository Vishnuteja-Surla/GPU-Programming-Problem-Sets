/*
Write a CUDA kernel which takes an integer parameter with value in the range
0..31 and creates a memory access pattern with coalescing degree equal to that
value. 31 indicates fully coalesced, while 0 indicates uncoalesced.
*/

#include<cuda.h>
#include<stdio.h>
#include<math.h>

__global__ void initArray(int *arr, int arrSize){
    unsigned tid = blockIdx.x * blockDim.x + threadIdx.x;
    if(tid < arrSize){
        arr[tid] = tid;
    }
}

__global__ void dCoalescedMemoryAccess(int *arr, int d){
    unsigned tid = threadIdx.x;
    
    int index;
    if (tid <= d) {
        index = tid;
    }
    else{
        index = 1024 + (32 * tid);
    }

    printf("Thread %2d reading index %4d (Val: %d)\n", tid, index, arr[index]);
}

int main(){
    int d;
    printf("Enter degree of coalescing (0 to 31): ");
    if (scanf("%d", &d) != 1 || d < 0 || d > 31) {
        printf("Invalid degree. Must be between 0 and 31.\n");
        return 1;
    }

    int arrSize = 4096;
    int *d_arr;
    cudaMalloc(&d_arr, arrSize * sizeof(int));

    int blockSize = 256;
    unsigned nblocks = (arrSize + blockSize - 1) / blockSize;
    initArray<<<nblocks, blockSize>>>(d_arr, arrSize);
    cudaDeviceSynchronize();

    dCoalescedMemoryAccess<<<1, 32>>>(d_arr, d);
    cudaDeviceSynchronize();

    cudaFree(d_arr);
    
    return 0;
}