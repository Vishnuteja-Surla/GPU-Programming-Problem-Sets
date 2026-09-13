/*
Write a kernel that takes at least one parameter d where d is the degree of divergence
in the range 0..32. 0 indicates no divergence, while 32 indicates that all the warp-
threads execute different instructions. Plot the times taken by this kernel for various
values of divergence.
*/

#include<cuda.h>
#include<stdio.h>
#include<sys/time.h>

#define NUM_BLOCKS 1024
#define THREADS_PER_BLOCK 256
#define ITERS 50000

__global__ void variedDivergence(int d){
    unsigned tid = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned laneid = threadIdx.x % 32;

    float val = (float)tid;

    if(d <= 0){
        for(int i=0; i<ITERS; i++){
            val = val * 1.0001f + 0.001f;
        }
    }
    else{
        for(int branch = 0; branch < d; branch++){
            if((laneid % d) == branch){
                for(int i=0; i<ITERS; i++){
                    val = val * 1.0001f + 0.001f;
                }
            }
        }
    }

    if (val == 0.0f) {
        printf("%f\n", val);
    }
}

int main(){
    struct timeval t1, t2;
    // Warm-up launch to force CUDA context initialization before timing starts
    variedDivergence<<<NUM_BLOCKS, THREADS_PER_BLOCK>>>(0);
    cudaDeviceSynchronize();

    for(int d = 0; d <= 32; d++){
        gettimeofday(&t1, NULL);

        variedDivergence<<<NUM_BLOCKS, THREADS_PER_BLOCK>>>(d);
        cudaDeviceSynchronize();

        gettimeofday(&t2, NULL);

        double seconds = t2.tv_sec - t1.tv_sec;
        double microSeconds = t2.tv_usec - t1.tv_usec;
        double elapsed_ms = (seconds * 1000.0) + (microSeconds / 1000.0);
	    printf("For divergence d = %d, Time taken (ms): %.3f\n", d, elapsed_ms);
    }

    return 0;
}