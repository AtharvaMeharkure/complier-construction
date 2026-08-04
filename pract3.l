%{
#include <stdio.h>

int count = 0;
%}

%%

[aA][a-zA-Z]*      { count++; }

\n                 ;

[ \t]+             ;

.                  ;

%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter text:\n");
    yylex();

    printf("Number of words starting with 'a' or 'A' = %d\n", count);

    return 0;
}
