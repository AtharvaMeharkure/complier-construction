%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
void yyerror(char *s);
%}

%%
[0-9]+          { yylval.num = atoi(yytext); return NUMBER; }
[a-z]           { yylval.id = yytext[0] - 'a'; return VARIABLE; } /* 26 variables: a to z */

"++"            { return INCREMENT; }
"--"            { return DECREMENT; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"* "            { return MULTIPLY; }
"/"             { return DIVIDE; }
"%"             { return MODULO; }
"="             { return ASSIGN; }
"\n"            { return NEWLINE; }
[ \t]           { /* skip whitespace */ }

.               { 
                  /* Lexical Error Recovery */
                  printf("Lexical Error: Invalid character '%s' skipped\n", yytext); 
                }
%%

int yywrap() { return 1; }

