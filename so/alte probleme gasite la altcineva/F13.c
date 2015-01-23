#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]){

	if(argc != 3){
		fprintf(stderr, "Utilizare: %s caracter fisier \n", argv[0]);
		return 1;
	}

  char moloz; 
  char str;
  FILE *f;
  f = fopen(argv[2], "r");
  if(!f)
  {
     perror(argv[2]);
     return -1;
  }
  
  moloz = argv[1][0];
  
  int counter = 0;

  do
  {
     str = (char)fgetc(f);
     if(str == moloz)
        counter++;
  }while(str != EOF);

  fclose(f);           
  printf("Numarul aparitii al lui %c %d", moloz, counter);

  return cunter;
}
