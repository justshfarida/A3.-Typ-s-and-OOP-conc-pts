#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#define MAX 100000
#define N 100000
//
// Created by User on 10/20/2026.
//
void create_array_instack() {
    int arr[N];
    arr[0] = 0;

}
void create_array_static() {
    static int arr[N];
    arr[0] = 0;

}
void create_array_inheap() {
    int *arr = malloc(N * sizeof(int));
    if (arr == NULL) return;
    arr[0] = 0;
    free(arr);

}
int main() {
    clock_t start, end;
    double cpu_time_stack;
    double cpu_time_static;
    double cpu_time_heap;

    start = clock();
    for (int i = 0; i < MAX; i++) {
        create_array_instack();
    }
    end = clock();
    cpu_time_stack = ((double) (end - start)) / CLOCKS_PER_SEC;

    start = clock();
    for (int i = 0; i < MAX; i++) {
        create_array_static();
    }
    end = clock();
    cpu_time_static = ((double) (end - start)) / CLOCKS_PER_SEC;

    start = clock();
    for (int i = 0; i < MAX; i++) {
        create_array_inheap();
    }
    end = clock();
    cpu_time_heap = ((double) (end - start)) / CLOCKS_PER_SEC;

    printf("Stack: %f\n", cpu_time_stack);
    printf("Static: %f\n", cpu_time_static);
    printf("Heap: %f\n", cpu_time_heap);

}