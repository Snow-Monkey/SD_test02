
#include <stdio.h>

int fib(int);

int main(void){

	for(int i=0; i<20; ++i){
		printf("%d\n", fib(i));
	}

	return 0;
}
