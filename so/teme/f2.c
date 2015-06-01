#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Give only one argument.");
        return 0;
    }
    int x = strtol(argv[1], NULL, 0);

    if (x%2 == 0) {
        printf("Nu e prim.\n");
        return 0;
    }
    int rad = sqrt(x);
    for (int i=3; i<=rad; i+=2) {
        if (x%i == 0) {
            printf("Nu e prim.\n");
            return 0;
        }
    }
    printf("E prim.\n");

    return 0;
}
