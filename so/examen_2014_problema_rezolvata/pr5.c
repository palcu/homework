#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int search(char *filename, char *str) {
    FILE * pFile;
    pFile = fopen(filename, "r");
    if (pFile == NULL) {
        perror("Error opening file.");
        exit(0);
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
    if (sol == 0)
        return -1;
    return sol;
}

int main() {
    int result = search("alex.txt", "bla");
    printf("%d", result);
    return 0;
}
