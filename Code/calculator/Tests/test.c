#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>

extern int test(char *expression);

char test_s[1000] = "";

void run_test(int testnum, int *failed)
{
    
    int a = rand() % 10000000;
    int b = rand() % 10000000;

    if(testnum == 4){
        a = abs(a) * -1;
        b = abs(b) * -1;
        testnum = abs (rand() % 4);
    }

    int validator;

    switch (testnum)
    {
    case 0:
        validator = a + b;
        sprintf(test_s, "%d+%d", a, b);
        break;
    case 1:
        validator = a - b;
        sprintf(test_s, "%d-%d", a, b);
        break;
    case 2:
        validator = a * b;
        sprintf(test_s, "%d*%d", a, b);
        break;
    case 3:
        validator = a / b;
        sprintf(test_s, "%d/%d", a, b);
        break;
    }
    int tested_value = test(test_s);
    *failed = !(tested_value == validator);
}

int main(int argc, char *argv[])
{

    srand(time(NULL));
    printf("Commencing tests... \n\n");

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

        for (int test = 0; test < 1 && !failed; test++)
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
    return 0;
}