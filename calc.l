%{
#include "calc.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+              { yylval.ival = atoi(yytext); return NUMBER; }
"sin"               { return SIN; }
"cos"               { return COS; }
"tan"               { return TAN; }
"log"               { return LOG10; }
"ln"                { return LN; }
"sqrt"              { return SQRT; }
"cbrt"              { return CBRT; }
"exp"               { return EXP; }
"!"                 { return FACT; }
"nCr"               { return NCR; }
"nPr"               { return NPR; }
"^"                 { return POW; }
"+"                 { return '+'; }
"-"                 { return '-'; }
"*"                 { return '*'; }
"/"                 { return '/'; }
"("                 { return '('; }
")"                 { return ')'; }
\n                  { return '\n'; }
[ \t]               ;
.                   { printf("Invalid token: %s\n", yytext); }

%%
int yywrap() { return 1; }
