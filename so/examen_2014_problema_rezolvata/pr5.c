#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int search(char *filename, char *str) {
    FILE * pFile;
    pFile = fopen(filename, "r");
    if (pFile == NULL) {
        return -1;
    }
    char line[256];
    int strLen = strlen(str), sol = 0;
    while (fgets(line, 256, pFile) != NULL) {
        char * ptr = line;
        while ((ptr = strstr(ptr, str)) != NULL) {
            sol += 1;
            ptr += strlen(str);
        }
    }
    fclose(pFile);

    return sol;
}

int main() {
    int result = search("alex.txt", "bla");
    printf("%d", result);
    return 0;
}
