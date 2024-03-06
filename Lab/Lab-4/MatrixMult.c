#include <stdio.h>
#include <stdlib.h>

int** matMult(int **a, int **b, int size) {
    int **result = (int **)malloc(size * sizeof(int *));
    for (int i = 0; i < size; i++) {
        result[i] = (int *)malloc(size * sizeof(int));
    }

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            result[i][j] = 0;
            for (int k = 0; k < size; k++) {
                result[i][j] += *(*(a + i) + k) * *(*(b + k) + j);
            }
        }
    }

    return result;
}

void printArray(int **arr, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d ", *(*(arr + i) + j));
        }
        printf("\n");
    }
}

int main() {
    int n = 3;
    int **matA, **matB, **matC;

    // Define 2 (n x n) arrays (matrices)
    matA = (int **)malloc(n * sizeof(int *));
    matB = (int **)malloc(n * sizeof(int *));

    for (int i = 0; i < n; i++) {
        matA[i] = (int *)malloc(n * sizeof(int));
        matB[i] = (int *)malloc(n * sizeof(int));
    }

    // Call printArray to print out the 2 arrays
    printf("Matrix A:\n");
    printArray(matA, n);
    printf("\nMatrix B:\n");
    printArray(matB, n);

    // Call matMult to multiply the 2 arrays
    matC = matMult(matA, matB, n);

    // Call printArray to print out resulting array
    printf("\nResult:\n");
    printArray(matC, n);

    // Free the allocated memory
    for (int i = 0; i < n; i++) {
        free(matA[i]);
        free(matB[i]);
        free(matC[i]);
    }
    free(matA);
    free(matB);
    free(matC);

    return 0;
}