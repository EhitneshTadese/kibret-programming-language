%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

// Helper functions
char* make_input_statement(const char* var, const char* prompt);
char* make_decl_statement(const char* var, const char* expr);
char* make_print_statement(const char* expr);
char* make_arith_expression(const char* left, const char* op, const char* right);
%}

/* Define value types */
%union {
    char* str;
}

/* Token types */
%token <str> IDENTIFIER
%token <str> STRING
%token <str> NUMBER

%token INPUT
%token PRINT
%token DECL

%type <str> statement expression program

%left '+' '-'
%left '*' '/'

%%

program
    : program statement { printf("%s\n", $2); free($2); }
    | statement         { printf("%s\n", $1); free($1); }
    ;

statement
    : INPUT IDENTIFIER '=' STRING ';'  { $$ = make_input_statement($2, $4); free($2); free($4); }
    | DECL IDENTIFIER '=' expression ';' { $$ = make_decl_statement($2, $4); free($2); free($4); }
    | PRINT STRING ';'                 { $$ = make_print_statement($2); free($2); }
    | PRINT IDENTIFIER ';'              { $$ = make_print_statement($2); free($2); }
    | PRINT expression ';'               { $$ = make_print_statement($2); free($2); }
    | IDENTIFIER '=' expression ';'     { $$ = make_decl_statement($1, $3); free($1); free($3); }
    ;

expression
    : expression '+' expression  { $$ = make_arith_expression($1, "+", $3); free($1); free($3); }
    | expression '-' expression  { $$ = make_arith_expression($1, "-", $3); free($1); free($3); }
    | expression '*' expression  { $$ = make_arith_expression($1, "*", $3); free($1); free($3); }
    | expression '/' expression  { $$ = make_arith_expression($1, "/", $3); free($1); free($3); }
    | IDENTIFIER                 { $$ = strdup($1); free($1); }
    | NUMBER                     { $$ = strdup($1); free($1); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}

char* make_input_statement(const char* var, const char* prompt) {
    char* buffer = malloc(strlen(var) + strlen(prompt) + 100);
    sprintf(buffer, "printf(\"%s\\n\"); scanf(\"%%d\", &%s);", prompt, var);
    return buffer;
}

char* make_decl_statement(const char* var, const char* expr) {
    char* buffer = malloc(strlen(var) + strlen(expr) + 20);
    sprintf(buffer, "int %s = %s;", var, expr);
    return buffer;
}

char* make_print_statement(const char* expr) {
    char* buffer = malloc(strlen(expr) + 100);

    // If expr contains non-digit (probably an identifier or string), use %s
    if (strspn(expr, "0123456789") == strlen(expr)) {
        // All digits (number)
        sprintf(buffer, "printf(\"%%d\\n\", %s);", expr);
    } else {
        // Otherwise string/variable
        sprintf(buffer, "printf(\"%%s\\n\", %s);", expr);
    }

    return buffer;
}

char* make_arith_expression(const char* left, const char* op, const char* right) {
    char* buffer = malloc(strlen(left) + strlen(op) + strlen(right) + 10);
    sprintf(buffer, "(%s %s %s)", left, op, right);
    return buffer;
}



int main(void) {
    yyparse();
    return 0;
}
 

