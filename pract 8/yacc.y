%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char *s);
int yylex();

/* A simple symbol table to store values for variables 'a' through 'z' */
int regs[26]; 
%}

%union {
    int num;
    int id;
}

%token <num> NUMBER
%token <id> VARIABLE
%token INCREMENT DECREMENT PLUS MINUS MULTIPLY DIVIDE MODULO ASSIGN NEWLINE

/* Operator Precedence (Bottom has the highest priority) */
%right ASSIGN
%left PLUS MINUS
%left MULTIPLY DIVIDE MODULO
%right INCREMENT DECREMENT  /* Prefix operators take high priority */

%type <num> exp

%%
input:
    /* empty */
    | input line
    ;

line:
    NEWLINE
    | exp NEWLINE       { printf("Result = %d\n", $1); }
    | VARIABLE ASSIGN exp NEWLINE { regs[$1] = $3; printf("%c = %d\n", $1 + 'a', $3); }
    | error NEWLINE     { 
                          /* Syntactical Error Recovery Hook */
                          yyerrok; 
                          printf("Syntax Error: Mathematical expression cleared. Try again.\n"); 
                        }
    ;

exp:
    NUMBER              { $$ = $1; }
    | VARIABLE          { $$ = regs[$1]; }
    | exp PLUS exp      { $$ = $1 + $3; }
    | exp MINUS exp     { $$ = $1 - $3; }
    | exp MULTIPLY exp  { $$ = $1 * $3; }
    | exp MODULO exp    { 
                            if($3 == 0) {
                                printf("Runtime Error: Modulo by zero!\n");
                                $$ = 0;
                            } else {
                                $$ = $1 % $3; 
                            }
                        }
    | exp DIVIDE exp    { 
                            if ($3 == 0) {
                                printf("Runtime Error: Division by zero!\n");
                                $$ = 0; /* Fallback recovery value */
                            } else {
                                $$ = $1 / $3; 
                            }
                        }
    /* Prefix Increment (++x): Increments variable first, then returns new value */
    | INCREMENT VARIABLE { regs[$2]++; $$ = regs[$2]; }
    
    /* Prefix Decrement (--x): Decrements variable first, then returns new value */
    | DECREMENT VARIABLE { regs[$2]--; $$ = regs[$2]; }
    ;
%%

void yyerror(char *s) {
    /* This function is automatically invoked when Yacc encounters 'error' */
    fprintf(stderr, "Parser Notice: %s\n", s);
}

int main() {
    printf("Desk Calculator Ready (Supports a-z, +, -, *, /, %%, ++, --)\n");
    return yyparse();
}

