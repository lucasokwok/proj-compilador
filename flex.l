%{
#include <stdlib.h>
#include <stdio.h>

#define NUM            300
#define ID             301
#define ELSE           302
#define IF             303
#define INT            304
#define RETURN         305
#define VOID           306
#define WHILE          307
#define SOMA           308
#define SUB            309
#define MUL            310
#define DIV            311
#define MENOR          312
#define MENOR_IGUAL    313
#define MAIOR          314
#define MAIOR_IGUAL    315
#define IGUAL          316
#define DIFERENTE      317
#define ATRIB          318
#define PONTO_VIRGULA  319
#define VIRGULA        320
#define ABRE_PAR       321
#define FECHA_PAR      322
#define ABRE_COL       323
#define FECHA_COL      324
#define ABRE_CHAVE     325
#define FECHA_CHAVE    326
#define FIM            327
#define ERR            328
%}

%x COMENTARIO

DIGITO  [0-9]
LETRA   [a-zA-Z]

%%
"else"          return ELSE;
"if"            return IF;
"int"           return INT;
"return"        return RETURN;
"void"          return VOID;
"while"         return WHILE;

{DIGITO}+       return NUM;
{LETRA}+        return ID;

"+"             return SOMA;
"-"             return SUB;
"*"             return MUL;
"/"             return DIV;

"<="            return MENOR_IGUAL;
"<"             return MENOR;
">="            return MAIOR_IGUAL;
">"             return MAIOR;
"=="            return IGUAL;
"!="            return DIFERENTE;
"="             return ATRIB;

";"             return PONTO_VIRGULA;
","             return VIRGULA;
"("             return ABRE_PAR;
")"             return FECHA_PAR;
"["             return ABRE_COL;
"]"             return FECHA_COL;
"{"             return ABRE_CHAVE;
"}"             return FECHA_CHAVE;

"/*"            BEGIN(COMENTARIO);
<COMENTARIO>"*/"   BEGIN(INITIAL);
<COMENTARIO>\n     ;
<COMENTARIO>.      ;
<COMENTARIO><<EOF>> return ERR;

[ \t\n]+        ;
<<EOF>>         return FIM;
.               return ERR;
%%

int main(int argc, char *argv[])
{
  int token, i, buf[100];
  FILE *f_in;
 
  for (i=0;i<=99;i++) buf[i] = 0;
 

  if (argc == 2)
  {
    if(f_in = fopen(argv[1],"r"))  yyin = f_in;
    else  perror(argv[0]);
  }
  else  yyin = stdin;
  
  i = 0;
  while ((token=yylex())!=FIM)
  {
    buf[i] = token;
    i++;
  }

  i = 0;
  while (buf[i] != 0)
  {
    switch(buf[i])
    {
      case NUM: printf("NUM "); break;
      case ID:  printf("ID ");  break;
      case SOM: printf("+ ");   break;
      case SUB: printf("- ");   break;
      case MUL: printf("* ");   break;
      case DIV: printf("/ ");   break;
      case IGL: printf(" = ");  break;
      case PEV: printf("; \n"); break;
      case APR: printf("( ");   break;
      case FPR: printf(") ");   break;
      case ERR: printf("ERR "); break;
    }
    i++;
  }
  return(0);
}

