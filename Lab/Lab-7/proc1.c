#include <stdio.h>

int SUM(int a, int b) {
    return a + b;
}

int main() {
    int m = 10;
    int n = 5;
    int result = SUM(m, n);
    printf("%d\n", result);
    return 0;
}

