#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <float.h>

extern char* calculate(char *expression);

char test_s[1000] = "";

FILE* report;

void run_test(int testnum, int *failed)
{
    
    int a = rand() % 10000000;
    int b = rand() % 10000000;

    if(testnum == 4){
        a = abs(a) * -1;
        b = abs(b) * -1;
        testnum = abs (rand() % 4);
    }

    double validator;

    switch (testnum)
    {
    case 0:
        validator = (double)a + (double)b;
        sprintf(test_s, "%d+%d", a, b);
        break;
    case 1:
        if ( a < b ){
            int aux = a;
            a = b;
            b = aux;
        }
        validator = (double)a - (double)b;
        sprintf(test_s, "%d-%d", a, b);
        break;
    case 2:
        validator = (double)a * (double)b;
        sprintf(test_s, "%d*%d", a, b);
        break;
    case 3:
        validator = (double)a / (double)b;
        sprintf(test_s, "%d/%d", a, b);
        break;
    }
    char* tested_value = calculate(test_s);
    char* pend;
    double k = strtod(tested_value, &pend);

    *failed = !( fabs( validator - k ) <= 0.000001 );

    char diagnostic[10];

    if(*failed){
        printf("%f", k);
        printf(" %f\n", validator);
    }
    

    if(*failed)
        strcpy(diagnostic, "FAIL");
    else
        strcpy(diagnostic, "PASS");

    
    fprintf(report, "Tested %s, got %f, expected %f, result is %s \n", test_s, k, validator, diagnostic);
}

int main(int argc, char *argv[])
{

    srand(time(NULL));
    printf("Commencing tests... \n\n");

    printf("Opening report file...\n");
    report = fopen("report.txt", "w+");

    float coverage = 0.0f;

    for (int op = 0; op < 5; op++)
    {
        int failed = 0;

        switch(op){
            case 0: printf("Testing addition... "); break;
            case 1: printf("Testing substraction... "); break;
            case 2: printf("Testing multiplication... "); break;
            case 3: printf("Testing division... "); break;
            case 4: printf("Testing negatives..."); break;
        }

        for (int test = 0; test < 10000 && !failed; test++)
        {
            run_test(op, &failed);
        }

        if (failed)
        {
            printf("[FAIL]\nTest failed: %s\n\n", test_s);
        }
        else
        {
            printf("[PASS]\n");
            coverage += 1.0f;
        }
    }
    coverage /= 5.0f;
    coverage *= 100;
    coverage = floor(coverage);
    printf("\nCoverage: %f %%\n" ,coverage);
    fclose(report);
    return 0;
}