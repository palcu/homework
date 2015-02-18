#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <errno.h>
#include <stdio.h>
#define KEY 3536

struct sembuf inc[1], dec[1];

void so() {
    puts("#so");
}

int myFunct(int semid, void (*f)()){
    if (semop(semid, dec, 1) == -1)
        return -1;
    so();
    if (semop(semid, inc, 1) == -1)
        return -1;
    return 0;
}

void set_operations() {
    inc[0].sem_num = 0;
    inc[0].sem_op = 1;
    inc[0].sem_flg = 0;

    dec[0].sem_num = 0;
    dec[0].sem_op = -1;
    dec[0].sem_flg = 0;
}

int main()
{
    set_operations();
    int semid = semget(KEY, 1, IPC_CREAT | 0666); // create 1 semaphore
    semctl(semid, 0, SETVAL, 1); // set its initial value to 1 (mutex semaphore)
    int ret = myFunct(semid, &so);
    return ret;
}
