%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int ncr(int n, int r) {
    return factorial(n) / (factorial(r) * factorial(n - r));
}

int npr(int n, int r) {
    return factorial(n) / factorial(n - r);
}
%}

%union {
    int ival;
    double fval;
}

%token <ival> NUMBER
%token SIN COS TAN LOG10 LN SQRT CBRT EXP FACT NCR NPR POW
%left '+' '-'
%left '*' '/'
%left POW
%right FACT

%type <fval> expr

%%

input:
    | input line
    ;

line:
    expr '\n'      { printf("Result = %lf\n", $1); }
    ;

expr:
      NUMBER                     { $$ = $1; }
    | expr '+' expr             { $$ = $1 + $3; }
    | expr '-' expr             { $$ = $1 - $3; }
    | expr '*' expr             { $$ = $1 * $3; }
    | expr '/' expr             { $$ = $1 / $3; }
    | expr POW expr             { $$ = pow($1, $3); }
    | '(' expr ')'              { $$ = $2; }
    | expr FACT                 { $$ = factorial($1); }
    | expr NCR expr             { $$ = ncr($1, $3); }
    | expr NPR expr             { $$ = npr($1, $3); }
    | SIN '(' expr ')'          { $$ = sin($3); }
    | COS '(' expr ')'          { $$ = cos($3); }
    | TAN '(' expr ')'          { $$ = tan($3); }
    | LOG10 '(' expr ')'        { $$ = log10($3); }
    | LN '(' expr ')'           { $$ = log($3); }
    | SQRT '(' expr ')'         { $$ = sqrt($3); }
    | CBRT '(' expr ')'         { $$ = cbrt($3); }
    | EXP '(' expr ')'          { $$ = exp($3); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Scientific Calculator (Flex + Bison)\n");
    printf("Example: sin(1), 5+3*2, 5 nCr 2, 4!\n");
    yyparse();
    return 0;
}
