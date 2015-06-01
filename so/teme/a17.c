 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
 #include <stdlib.h>

 int main(int argc, char *argv[]) {
    const int MAX_SIZE = 256;
    char cwd[MAX_SIZE], nwd[MAX_SIZE], var[MAX_SIZE];

    if (argc != 2) {
        return 0;
    }

    // Get vars
    getcwd(cwd, sizeof(cwd));
    printf("== Before modifications ==\n");
    printf("getcwd = %s\n", cwd);
    printf("PWD = %s\n", (char *) getenv("PWD"));

    // Set PWD
    strcpy(var, "PWD=");
    strcat(var, argv[1]);
    putenv(var);

    // Get vars again
    printf("== After modifications ==\n");
    getcwd(nwd, sizeof(nwd));
    printf("getcwd = %s\n", nwd);
    printf("PWD = %s\n", (char *) getenv("PWD"));

    return 0;
}
