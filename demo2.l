%{ 
#include <stdio.h> 
int count = 0;
%} 

%% 
"//".*        { count++; } /* Match // followed by any characters except newline */
.|\n          { } 
%% 

int main() { 
    printf("Enter code/text containing comments:\n"); 
    yylex(); 
    printf("I caught you %d times\n", count);
    return 0; 
} 

int yywrap() { 
    return 1; /* MUST always return 1 to terminate input stream */
}

