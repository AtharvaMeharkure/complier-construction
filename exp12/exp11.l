%{
#include "exp11.tab.h"
#include <string.h>
%}

%%
[0-9]+                      { yylval.str = strdup(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*      { yylval.str = strdup(yytext); return ID; }
[-+*/=();]                  { return yytext[0]; } /* Returns the character value as an int */
[ \t\n\r]                   { /* Strictly ignore all spaces, tabs, newlines, and carriage returns */ }
.                           { return yytext[0]; } /* Returns the character value as an int */
%%

int yywrap() { 
    return 1; 
}
