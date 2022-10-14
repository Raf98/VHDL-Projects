#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>


int main(int argc, char const *argv[])
{
    FILE* file = fopen("C:\\Users\\LPDar\\Documents\\SDA\\Somadores\\RippleCarry2\\entrada.txt", "w");
    if(file == NULL)
    {
        printf("Error 1");
        exit(1);
    } 


    char strA[34];
    char strB[34];
    char currBinA;
    char currBinB;

    srand(time(NULL));
    for(int j=0; j < 10; j++)
    {

    for(int i = 0; i < 32; i++)
    {
        currBinA = rand()%2;
        currBinB = rand()%2;

        strA[i] = currBinA + 48;
        strB[i] = currBinB + 48;

        printf("%c\n", strA[i]);
        printf("%c\n", strB[i]);

        //strcat(strA, currBinA);
        //strcat(strB, currBinB);
    }

    strA[32] = '\n';
    strA[33] = '\0';
    strB[32] = '\n';
    strB[33] = '\0';

    fputs(strA, file);
    fputs(strB, file);

    }
    fclose(file);




    file = fopen("C:\\Users\\LPDar\\Documents\\SDA\\Somadores\\CarrySelect\\entrada.txt", "w");
    if(file == NULL)
    {
        printf("Error 1");
        exit(1);
    } 


    char strACS[34];
    char strBCS[34];
    char currBinACS;
    char currBinBCS;

    //srand(time(NULL));
     for(int j=0; j < 10; j++)
    {

    for(int i = 0; i < 32; i++)
    {
        currBinACS = rand()%2;
        currBinBCS = rand()%2;

        strACS[i] = currBinACS + 48;
        strBCS[i] = currBinBCS + 48;

        printf("%c\n", strACS[i]);
        printf("%c\n", strBCS[i]);

        //strcat(strA, currBinA);
        //strcat(strB, currBinB);
    }

    strACS[32] = '\n';
    strACS[33] = '\0';
    strBCS[32] = '\n';
    strBCS[33] = '\0';

    fputs(strACS, file);
    fputs(strBCS, file);
    }

    fclose(file);




    return 0;
}
