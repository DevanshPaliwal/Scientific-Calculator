# Scientific-Calculator
Scientific Calculator in C using Lex and Yacc 

## Compile it using  

```bash
bison -d calc.y
flex calc.l
gcc calc.tab.c lex.yy.c -lm -o calc
./calc
