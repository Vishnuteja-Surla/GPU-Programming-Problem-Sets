/*
Write a kernel with if condition but without any thread-divergence.
*/

#include<cuda.h>
#include<stdio.h>

__global__ void comparator(int a, int b){
    if(a < b){
        printf("%d is less than %d\n", a, b);
    }
    else if(a == b){
        printf("%d is equal to %d\n", a, b);
    }
    else{
        printf("%d is greater than %d\n", a, b);
    }
}

int main(){
    int a = 10;
    int b = 15;
    comparator<<<1, 32>>>(a, b);
    cudaDeviceSynchronize();
    return 0;
}