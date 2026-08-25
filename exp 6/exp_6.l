%{
#include <stdio.h>

int stringToNumber(char str[])
{
    int num = 0;
    int i = 0;
    while (str[i] != '\0')
    {
        num = num * 10 + (str[i] - '0');
        i++;
    }
    return num;
}

void decimalToHex(int num)
{
    char hex[] = "0123456789ABCDEF";
    char result[20];
    int i = 0;
    if (num == 0)
    {
        printf("Hexadecimal: 0\n");
        return;
    }

    while (num > 0)
    {
        result[i] = hex[num % 16];
        num = num / 16;
        i++;
    }

    printf("Hexadecimal: ");
    while (i > 0)
    {
        i--;
        printf("%c", result[i]);
    }
    printf("\n");
}
%}

%%
[0-9]+ {
    int num;

    num = stringToNumber(yytext);

    printf("Decimal: %d\n", num);

    decimalToHex(num);
}
.|\n {
    
}
%%
int main()
{
    printf("Reading decimal number from file\n");

    yylex();

    return 0;
}
int yywrap()
{
    return 1;
}
