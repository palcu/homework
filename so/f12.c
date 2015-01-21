#include <stdio.h>

long count_characters(FILE *f){
    fseek(f, -1, 2);
    long last_pos = ftell(f);
    last_pos++;
    return last_pos;
}

int main(int argc, char * argv[]){
    int i=0, cnt;
    char ch, chars[256];
    FILE *fp1;

    if ((fp1 = fopen(argv[1], "r"))) {
        cnt = count_characters(fp1);
        fseek(fp1, -1, 2); // pune pointerul pe ultima pozitie

        int temp_cnt = cnt;
        while (temp_cnt) {
            chars[i++] = fgetc(fp1);
            fseek(fp1, -2, 1); // mergi in spate cu un caracter
            temp_cnt--;
        }
    } else {
        return 0;
    }
    fp1 = fopen(argv[1], "w");
    for (int i=0; i<cnt; i++)
        putc(chars[i], fp1);

    fclose(fp1);
    return 0;
}
