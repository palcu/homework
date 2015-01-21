#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        return 0;
    }
    int a = strtol(argv[1], NULL, 0);
    int b = strtol(argv[2], NULL, 0);

    int r;
    while (b) {
        r = a % b;
        a = b;
        b = r;
    }
    printf("%d\n", a);

    return 0;
}
