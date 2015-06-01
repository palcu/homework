#include <signal.h>
#include <stdio.h>
#include <unistd.h>

void handler(int signum) {
    char s[256];
    sprintf(s, "Am primit semnal %d\n", signum);
    write(1, s, sizeof(s));
}

int main() {
    int i;
    for (i=0; i<NSIG; i++) {
        signal(i, handler);
    }
    while (1) {
        sleep(1);
    }
    return 0;
}
