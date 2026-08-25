%{
#include <stdio.h>

char changeCase(char c) {
    if (c >= 'a' && c <= 'z')
        return c - 'a' + 'A';
    else if (c >= 'A' && c <= 'Z')
        return c - 'A' + 'a';

    return c;
}
%}

%%
[a-zA-Z]+ {
    for (int i = 0; yytext[i] != '\0'; i++) {
        putchar(changeCase(yytext[i]));
    }
}

. {
    putchar(yytext[0]);
}
%%

int main() {
    printf("Enter a String: ");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
