%{
#include "kibret_parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%
[ \t\r\n]+        ; // Skip whitespace

"print"           { return PRINT; }

[0-9]+            { yylval.intval = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.strval = strdup(yytext); return IDENTIFIER; }

\"[^\"]*\"        {
    yylval.strval = strdup(yytext + 1);
    yylval.strval[strlen(yylval.strval) - 1] = '\0';
    return STRING;
}

"="               { return '='; }
";"               { return ';'; }
"("               { return '('; }
")"               { return ')'; }
"+"               { return '+'; }
"-"               { return '-'; }
"/"               { return '/'; }

.                 { return yytext[0]; }
%%

int yywrap() { return 1; }