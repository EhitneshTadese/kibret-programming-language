%{
#include "kibret_parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

[ \t\r\n]+        ; // Skip whitespace

"input"           { return INPUT; }
"print"           { return PRINT; }
"decl"            { return DECL; }

[0-9]+            { yylval.str = strdup(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return IDENTIFIER; }

\"[^\"]*\"        {
    yylval.str = strdup(yytext + 1);
    yylval.str[strlen(yylval.str) - 1] = '\0';
    return STRING;
}

"="               { return '='; }
";"               { return ';'; }
"+"               { return '+'; }
"-"               { return '-'; }
"/"               { return '/'; }

.                 { return yytext[0]; }
%%

int yywrap() { return 1; }