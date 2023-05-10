#include<stdio.h>
#include<stdlib.h>
__global__ void print_from_gpu(void){
    printf("hellow world from GPU. From thread [%d,%d] \
		From device\n", threadIdx.x,blockIdx.x);
}

int main(void){
    printf("Hellow world from CPU\n");
    print_from_gpu<<<1,1>>>();
    cudaDeviceSynchronize();
    return 0;
}