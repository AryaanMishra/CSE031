#include <stdio.h>
int main() {
    int x = 0;
	int y = 0;
	int arr[10] = {0};

	printf("Address of x: %p\n", (void *)&x);
	printf("Address of y: %p\n", (void *)&y);

	int *px = &x;
	int *py = &y;

	printf("Value of px: %p, \nAddress of px: %p\n", (void *)px, (void *)&px);
	printf("Value of py: %p, \nAddress of py: %p\n", (void *)py, (void *)&py);

	for(int i = 0; i < 10; i++) {
    	printf("%d ", *(arr + i));
	}

	printf("\n");
  	printf("%p == %p\n", (void *)arr, (void *)&arr[0]);
	printf("Address of arr: %p\n", (void *)arr);

    return 0;
}
