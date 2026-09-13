/*
Create an array of strings (character arrays or STL strings) on the CPU. 
Transfer these to the GPU and print the strings from various threads.
*/

#include<cuda.h>
#include<stdio.h>
#include<math.h>

#define NUMSTR 3
#define MAXSTRLEN 30
#define BLOCK 1024

__global__ void printString(char *strings){
    unsigned tid = blockIdx.x * blockDim.x + threadIdx.x;
    if(tid < NUMSTR){
        printf("%d: %s\n", tid, strings + (tid * MAXSTRLEN));
    }
}

int main(){
    char strings[NUMSTR][MAXSTRLEN] = {"GPU", "CUDA", "Programming"}, *dstrings;
    
    cudaMalloc(&dstrings, NUMSTR * MAXSTRLEN * sizeof(char));
    cudaMemcpy(dstrings, strings, NUMSTR * MAXSTRLEN * sizeof(char), cudaMemcpyHostToDevice);
    unsigned nblocks = ceil((float)NUMSTR/BLOCK);
    printString<<<nblocks, BLOCK>>>(dstrings);
    cudaDeviceSynchronize();
    
    return 0;
}