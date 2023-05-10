#include<stdio.h>
#include<stdlib.h>

#define N 10

void host_add(int *a, int *b, int *c){
    for(int i = 0; i < N; i++){
        c[i] = a[i] + b[i];
    }
}

__global__ void device_add(int *a, int *b, int *c){
    c[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];
}

void init_array(int *data){
    for(int i = 0; i < N; i++){
        data[i] = i*2;
    }
}

void print_result(int *a, int *b, int *c){
    for(int i = 0; i < N; i++)
    printf("%d + %d = %d \n", a[i], b[i], c[i]);
}

int main(void){
    int *a, *b, *c;
    int *d_a, *d_b, *d_c;

    int size = N * sizeof(int);

    //allocate space for host copies of a, b, c and init the vectors
    a = (int *)malloc(size);
    init_array(a);
    b = (int *)malloc(size);
    init_array(b);
    c = (int *)malloc(size);

    //allocate space for device copies of a, b, c
    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    device_add<<<N,1>>>(d_a, d_b, d_c);
    // Copy result back to host
    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

	print_result(a,b,c);

	free(a); free(b); free(c);
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);

    return 0;
}