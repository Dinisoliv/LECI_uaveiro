#include <stdio.h>

int main() {
    printf("sizeof(void *) ...... %zu\n", sizeof(void *));
    printf("sizeof(void) ........ %zu\n", sizeof(void));
    printf("sizeof(char) ........ %zu\n", sizeof(char));
    printf("sizeof(short) ....... %zu\n", sizeof(short));
    printf("sizeof(int) ......... %zu\n", sizeof(int));
    printf("sizeof(long) ........ %zu\n", sizeof(long));
    printf("sizeof(long long) ... %zu\n", sizeof(long long));
    printf("sizeof(float) ....... %zu\n", sizeof(float));
    printf("sizeof(double) ...... %zu\n", sizeof(double));

    return 0;
}