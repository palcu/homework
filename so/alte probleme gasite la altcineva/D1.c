#include <sys/stat.h>
#include <unistd.h>
#include <dirent.h>
#include <error.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int read_dir(char *pth)
{
    char path[1000];
    strcpy(path,pth);
    DIR *dp;
    struct dirent *file;
    /*structure for storing inode numbers and file in dir
    struct dirent
    {
        ino_t d_ino;
        char d_name[NAME_MAX+1]
    }
    */
    if((dp=opendir(path))==NULL)
        perror("dir\n");
    char newp[1000];
    struct stat buf;
    int ok =0;
    while((file=readdir(dp))!=NULL)
    {
      if(!strcmp(file->d_name,".") 
      	|| !strcmp(file->d_name,".."))
        continue;

        strcpy(newp,path);
        strcat(newp,"/");
        strcat(newp,file->d_name);
      /*  int i, ret=0;
		for (i=0; newp[i]; i++)
			ret++;
		char space[ret];
		for(i=0;i<ret;i++)
		{
			if(i==0)
				space[i] = '|';
			else
				space[i] = '-';
		}  
        printf("%s\n",space);*/
        if(stat(newp,&buf)==-1)
        perror("stat");
        if(ok==0 && S_ISDIR(buf.st_mode))
        {
           	int i=0;
        	for(i=0; i<strlen(newp); i = i+2)
        	{
        		if(i==0)
        			printf("|");
        		else 
        			printf("-");
        	}

        	printf("%s\n", file->d_name);
        }
        else if(ok == 0)
        {
        	printf("%s\n", newp);

        	ok=1;
        }
        else
        {
        	int i=0;
        	for(i=0; i<strlen(newp); i = i+2)
        	{
        		if(i==0)
        			printf("|");
        		else 
        			printf("-");
        	}

        	printf("%s\n", file->d_name);
        }
       // printf("%s\n", newp);
            //stat function return a structure
            // of information about the file    
        if(S_ISDIR(buf.st_mode))// if directory, then 
            //add a "/" to current path
        {

            strcat(path,"/");
            strcat(path,file->d_name);
            read_dir(path);
            strcpy(path,pth);
        }
    }
}
int main(int argc,char *argv[])
{

    read_dir(argv[1]);
}