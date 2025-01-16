#include <stdio.h>

int main(void){
    int nmults = 0;
    
    int ndivs = 0;
    for (int i = 100; i < 1000; i++)
    {
        int c = i / 100;
        int d = (i % 100) / 10;
        int u = i % 10;

        ndivs += 4;

        if (i == c*c*c + d*d*d + u*u*u)
        {
            printf("Found: %d\n" , i);
        }

        nmults += 6; 
        
    }

    printf("Número de divisões: %d \n", ndivs);
    printf("Número de multiplições: %d \n", nmults);

    nmults = 0;

        int power3[10] = {0, 1, 8, 27, 64, 125, 216, 343, 512, 729};

        for (int c = 1; c < 10; c++)
        {
            for (int d = 0; d < 10; d++)
            {
                for (int u = 0; u < 10; u++)
                {
                    nmults += 2;
                    int number = c*100 + d*10 + u;
                    if ((number) == (power3[c] + power3[d] + power3[u]))
                    {
                        printf("Found: %d \n", number);
                    }
                     
                }
                
            }
            
        }
    
    printf("Número de multiplicações: %d\n", nmults);
    
}