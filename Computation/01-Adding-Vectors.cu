/*
Write a CUDA program to add two vectors of the same size. 
Modify the program to make it work even if the vector sizes are different
*/

#include<cuda.h>
#include<stdio.h>
#include<math.h>
#define M 7
#define N 5

__global__ void addVectors(int *a, int *b, int *result, int maxSize){
    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    if(tid < maxSize){
        if(tid < M && tid < N){
            result[tid] = a[tid] + b[tid];
        }
        else if(tid < M){
            result[tid] = a[tid];
        }
        else if(tid < N){
            result[tid] = b[tid];
        }
    }
}

int main(){
    int a[M] = {1, 2, 3, 4, 5, 6, 7};
    int b[N] = {11, 12, 13, 14, 15};
    int maxSize = max(M, N);
    int *result = (int *)malloc(maxSize * sizeof(int));

    int *da, *db, *dresult;
    cudaMalloc(&da, M * sizeof(int));
    cudaMalloc(&db, N * sizeof(int));
    cudaMalloc(&dresult, maxSize * sizeof(int));
    cudaMemcpy(da, a, M * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(db, b, N * sizeof(int), cudaMemcpyHostToDevice);

    addVectors<<<M, N>>>(da, db, dresult, maxSize);

    cudaMemcpy(result, dresult, maxSize * sizeof(int), cudaMemcpyDeviceToHost);


    for(int i=0; i<maxSize; i++){
        printf("%d\t", result[i]);
    }
    printf("\n");

    return 0;
}