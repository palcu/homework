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
        for (int i = 0; line[i] != NULL; i++) {
            if (line[i] == str[0]) {
                int indexLine = i, indexStr = 0;
                int suntEgale = 1;
                while (line[indexLine] != NULL && str[indexStr] != NULL) {
                    if (line[indexLine] != str[indexStr]) {
                        suntEgale = 0;
                        break;
                    }
                    indexLine++; indexStr++;
                }
                if (suntEgale && indexStr == strLen)
                    sol++;
            }
        }
    }
    return sol;
}

int main() {
    int result = search("alex.txt", "bla");
    printf("%d", result);
    return 0;
}
