%{
#include <stdio.h>
%}

%%
.*COM$    { printf("Line ends with COM: %s\n", yytext); }
.*        { printf("Line does not end with COM: %s\n", yytext); }
%%

int main()
{
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}
