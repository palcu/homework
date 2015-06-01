#include <unistd.h>
#include <stdio.h>
#include <dirent.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <errno.h>

int myFunct(char *dir) {
    int sz = 0;
    DIR *foo = opendir(dir);
    if (foo == NULL) {
        return -1;
    }
    struct dirent *ent;
    while ((ent = readdir(foo)) != NULL) {
        ent = readdir(foo);
        struct stat st;
        errno = 0;
        int exists = stat(ent->d_name, &st);
        if (exists < 0) {
            perror("plm");
            printf("%s\n", ent->d_name);
        } else {
            if (S_ISREG(st.st_mode)) {
                sz += st.st_size;
            }
        }
    }
    printf("%d\n", sz);
    return 0;
}

int main() {
    char *myDir = ".";
    return myFunct(myDir);
}
