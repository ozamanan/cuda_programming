#include<stdio.h>
#include<stdlib.h>

#define N 10

void host_add(int *a, int *b, int *c){
    for(int i = 0; i < N; i++){
        c[i] = a[i] + b[i];
    }
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
    int size = N*sizeof(int);

    //allocate space for host copies of a, b, c, and init the vectors
    a = (int *)malloc(size);
    init_array(a);
    b = (int *)malloc(size);
    init_array(b);
    c = (int *)malloc(size);
    
    //addition
    host_add(a, b, c);

    print_result(a, b, c);

    free(a); free(b); free(c);

    return 0;
}