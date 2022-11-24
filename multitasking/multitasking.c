#define NPROC 9
#define SSIZE 1024

typedef struct proc
{
	struct proc *next;
	int *ksp;
	int pid;
	int kstack[SSIZE];
} PROC;

PROC proc[NPROC], *running;
int procSize = sizeof(PROC);

int body()
{
	char c;
	int pid = running->pid;
	printf("proc %d running to body()\n", pid);
	while (1)
	{
		printf("proc %d running, enter a key:\n", pid);
		c = getc();
		tswitch();
	}
}

int init()
{
	PROC *p;
	int i, j;
	for (i = 0; i < NPROC; i++)
	{
		p = &proc[i];
		p->pid = i;
		p->next = &proc[i + 1];
		if (i)
		{
			p->kstack[SSIZE - 1] = (int)body;
			for (j = 2; j < 10; j++)
			{
				p->kstack[SSIZE - j] = 0;
			}
			p->ksp = &(p->kstack[SSIZE - 9]);
		}
	}
	proc[NPROC - 1].next = &proc[0];
	running = &proc[0];
	printf("init complete\n");
}

int scheduler()
{
	running = running->next;
}

int main()
{
	init();
	while (1)
	{
		printf("proc 0 running\n");
		tswitch();
	}
}
