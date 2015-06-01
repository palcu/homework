#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    freopen("errors.txt", "w", stdout);
    for (int i=0; i<=128; i++) {
        errno = i;
        printf("%d: %s\n", errno, strerror(errno));
    }
    return 0;
}
