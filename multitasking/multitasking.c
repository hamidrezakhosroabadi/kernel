#define SSIZE 1024

typedef struct proc
{
	struct proc *next;
	int *ksp;
	int kstack(SSIZE);
} PROC;

int procSize = sizeof(PROC);

PROC proc0,
	*running;

int scheduler()
{
	running = &proc0;
}

int main()
{
	running = &proc0;

	tswitch();

	printf("\n Task was switched! \n");

}
