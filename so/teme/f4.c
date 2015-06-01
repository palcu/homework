#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Give only one argument.");
        return 0;
    }
    int x = strtol(argv[1], NULL, 0);

    int sol = 0;
    while (x) {
        sol += x%10;
        x /= 10;
    }
    printf("%d\n", sol);

    return 0;
}
