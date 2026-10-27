%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int temp_count = 0;

// Logic to generate unique temporary variables
char* newTemp() {
    char* buf = malloc(10);
    sprintf(buf, "t%d", temp_count++);
    return buf;
}

void yyerror(const char *s);
int yylex();
%}

%union {
    char* str;
}

%token <str> ID NUM
%type <str> exp

/* Precedence rules: Lower down means higher priority */
%right '='
%left '+' '-'
%left '*' '/'

%%

/* Base entry point allows parsing to finish and exit cleanly */
input:
    statement { exit(0); }
    ;

statement:
    ID '=' exp ';' { 
        printf("%s = %s\n", $1, $3); 
    }
    ;

exp:
    exp '+' exp { 
        $$ = newTemp(); 
        printf("%s = %s + %s\n", $$, $1, $3); 
    }
    | exp '-' exp { 
        $$ = newTemp(); 
        printf("%s = %s - %s\n", $$, $1, $3); 
    }
    | exp '*' exp { 
        $$ = newTemp(); 
        printf("%s = %s * %s\n", $$, $1, $3); 
    }
    | exp '/' exp { 
        $$ = newTemp(); 
        printf("%s = %s / %s\n", $$, $1, $3); 
    }
    | '(' exp ')' { 
        $$ = $2; 
    }
    | ID { 
        $$ = $1; 
    }
    | NUM { 
        $$ = $1; 
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter arithmetic expression (e.g., x = a + b * c;):\n");
    yyparse();
    return 0;
}

