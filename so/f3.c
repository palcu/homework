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
    while (x%2 == 0) {
        sol += 1;
        x/=2;
    }
    if (sol) printf("2 %d\n", sol);
    int rad = sqrt(x);
    for (int i=3; i<=rad && x!=1; i+=2) {
        sol = 0;
        while (x%i == 0) {
            x /= i;
            sol += 1;
        }
        if (sol) printf("%d %d\n", i, sol);
    }

    return 0;
}
