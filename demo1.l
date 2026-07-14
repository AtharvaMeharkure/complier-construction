%{ 
#include <stdio.h> 
%} 

%% 
"pen" { printf("i caught you"); } 
.|\n  { } 
%% 

int main() { 
    printf("enter a paragraph:\n"); 
    yylex(); 
    return 0; 
} 

int yywrap() { 
    return 1; 
}

