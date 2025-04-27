#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
extern FILE *out;
int yyparse();

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <source.kibret> <output.c>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error opening input file");
        return 1;
    }

    out = fopen(argv[2], "w");
    if (!out) {
        perror("Error opening output file");
        return 1;
    }

    // Write C boilerplate
    fprintf(out, "#include <stdio.h>\n\nint main() {\n");

    yyparse();

    fprintf(out, "return 0;\n}\n");

    fclose(yyin);
    fclose(out);

    printf("Transpilation successful! Output written to %s\n", argv[2]);

    return 0;
}







// This is the main driver file for the Kibret transpiler. It takes in a Kibret source code file 
// as input and outputs a C file. It opens the source file, processes it through the parser, 
// and generates equivalent C code in the output file.
