#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

int myFunct(char *fis) {
    int desc = open(fis, O_WRONLY | O_APPEND);
    if (desc < 0) {
        perror("Nu s-a deschis fisierul.");
        return -1;
    }
    struct stat st;
    fstat(desc, &st);
    int to_write = 256 - st.st_size % 256;
    printf("%lld %d\n", st.st_size, to_write);
    for (int i=0; i<to_write; i++) {
        int resp = write(desc, "1", sizeof(char));
        if (resp < 0) {
            perror("Nu s-a scris.");
            return -1;
        }
    }
    return 0;
}

int main() {
    return myFunct("fisier.txt");
}
