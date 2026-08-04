%{
#include <stdio.h>
#include <string.h>

int comments=0, keywords=0, identifiers=0;
int words=0, lines=1, spaces=0;

char *kw[]={
"auto","break","case","char","const","continue","default","do",
"double","else","enum","extern","float","for","goto","if","int",
"long","register","return","short","signed","sizeof","static",
"struct","switch","typedef","union","unsigned","void","volatile","while"
};

int isKeyword(char *s)
{
    for(int i=0;i<32;i++)
        if(strcmp(s,kw[i])==0)
            return 1;
    return 0;
}
%}

ID [a-zA-Z_][a-zA-Z0-9_]*

%%

"//".*                              { comments++; }
"/*"([^*]|\*+[^*/])*\*+"/"          { comments++; }

\n                                  { lines++; }
[ ]                                 { spaces++; }
[\t]+                               ;

{ID}                                {
                                        words++;
                                        if(isKeyword(yytext))
                                            keywords++;
                                        else
                                            identifiers++;
                                    }

[0-9]+                              { words++; }

[^ \t\n]+                           { words++; }

%%

int yywrap()
{
    return 1;
}

int main()
{
    yyin = fopen("input.c","r");

    if(!yyin)
    {
        printf("File not found\n");
        return 0;
    }

    yylex();

    printf("Comments    : %d\n",comments);
    printf("Keywords    : %d\n",keywords);
    printf("Identifiers : %d\n",identifiers);
    printf("Words       : %d\n",words);
    printf("Lines       : %d\n",lines);
    printf("Spaces      : %d\n",spaces);

    fclose(yyin);
    return 0;
}
