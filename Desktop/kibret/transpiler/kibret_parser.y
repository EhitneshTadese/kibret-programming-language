%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

// Forward declarations
int yylex(void);
void yyerror(const char *s);
void emit(const char *fmt, ...);
%}

%union {
    int intval;
    char* strval;
}

%token <strval> IDENTIFIER STRING
%token <intval> NUMBER
%token PRINT PRINTSTR

%type <strval> expression
%type <strval> statement

%%

program:
    statements
;

statements:
      statements statement
    | statement
;

statement:
      PRINT expression ';'    { emit("printf(\"%%d\\n\", %s);\n", $2); free($2); }
    | PRINT STRING ';'        { emit("printf(\"%%s\\n\", \"%s\");\n", $2); free($2); }
;

expression:
      NUMBER {
          char buf[32];
          sprintf(buf, "%d", $1);
          $$ = strdup(buf);
      }
    | IDENTIFIER {
          $$ = $1;
      }
    | expression '+' expression {
          char *buf = malloc(strlen($1) + strlen($3) + 4);
          sprintf(buf, "(%s+%s)", $1, $3);
          $$ = buf;
          free($1);
          free($3);
      }
;

%%


void emit(const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    vprintf(fmt, args);
    va_end(args);
}

void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}

int main() {
    printf("#include <stdio.h>\n\nint main() {\n");
    yyparse();
    printf("return 0;\n}\n");
    return 0;
}