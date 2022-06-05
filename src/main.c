#include <stdio.h>
#include <stdlib.h>
#include "pole.h"
#include "objetosc.h"


int main(){
    
    while(1 == 1)
    {
        int wybor;
	printf("1 -> policz pole\n");
	printf("2 -> policz objetosc\n");
        printf("\n");
	printf("wybor = ");
	scanf("%d", &wybor);

	int wymiar;

	printf("\n\n");
	printf("podaj wymiar: ");
	scanf("%d", &wymiar);

	printf("\n");
	if(wybor == 1)
	{
            int poleKwadratu = ObliczPole(wymiar);
            printf("pole kwadratu 4x4 = %d\n", poleKwadratu);
	}else if(wybor == 2){
            int objetoscSzesicianu = ObliczObjetosc(wymiar);
            printf("Objetosc szescianu 4x4x4 =  %d\n", objetoscSzesicianu);
	}

	printf("\n\n");
    }
	

    exit(EXIT_SUCCESS);
}
