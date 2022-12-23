%{
/* se necesita esto para la llamada a atof() m�s abajo */
#include <math.h>
#include <stdio.h>
#include <string.h>
int matriculas=0;
%}

/*[^A-Za-z0-9]? */
DIGITOS   [0-9]{4}
CONSONANTESEUROPEAS [B-DF-HJ-NPR-TV-Z]{3}
ID       [a-z][a-z0-9]*
PROVINCIAL ([A-Z][A-Z]?{DIGITOS}[A-Z]{2})
EUROPEAS (\b)?{DIGITOS}[ -]*{CONSONANTESEUROPEAS}([^A-Za-z0-9]|"\0")

FUERZAESTADO  (\b)?("PGC"|"CNP"|"ET"|"EA"|"FN"|"E"|"CGPC")[ -]*{DIGITOS}[ -]*[B-DF-HJ-NPR-TV-Z]([^A-Za-z0-9]|"\0")
CICLOMOTOR  (\b)?"C"[ -]*{DIGITOS}[ -]*{CONSONANTESEUROPEAS}([^A-Za-z0-9]|"\0")
DIPLOMATICAS  (\b)?("CD"|"CC"|"TA"|OI)[ -]*[0-9]{2}[ -]*[0-9]{3}([^A-Za-z0-9]|"\0")
REMOLQUES  (\b)?"R"[ -]*{DIGITOS}[ -]*{CONSONANTESEUROPEAS}([^A-Za-z0-9]|"\0")
QUADS  (\b)?"E"[ -]*{DIGITOS}[ -]*{CONSONANTESEUROPEAS}([^A-Za-z0-9]|"\0")
PROVISIONAL  (\b)?("P"|"S"|"B")[ -]*{DIGITOS}[ -]*{CONSONANTESEUROPEAS}([^A-Za-z0-9]|"\0")
TURISTICAS  (\b)?"T"[ -]*{DIGITOS}[ -]*{CONSONANTESEUROPEAS}([^A-Za-z0-9]|"\0")
HISTORICO  (\b)?"H"[ -]*{DIGITOS}[ -]*{CONSONANTESEUROPEAS}([^A-Za-z0-9]|"\0")

%%

{PROVINCIAL}+   {
            printf( "MATRICULA PROVINCIAL: %s\n", yytext);
            }



{EUROPEAS}   {
        matriculas++;
       char * x ;
        x = yytext;
        if (  x[strlen(x) - 1] != '\0')
                x[strlen(x) - 1] = '\0';
        printf( "MATRICULA EUROPEA ACTUAL: %s\n", x);
}


{FUERZAESTADO}+   {
       
            printf( "MATRICULA DE FUERZA DEL ESTADO: %s\n", yytext);
            }
{CICLOMOTOR}+   {      
            printf( "MATRICULA DE CICLOMOTOR: %s\n", yytext);
}

{DIPLOMATICAS}+   {      
            printf( "MATRICULA DIPLOMATICA: %s\n", yytext);
}
{REMOLQUES}+   {      
            printf( "MATRICULA DE REMOLQUE: %s\n", yytext);
}

{QUADS}+   {      
            printf( "MATRICULA DE QUAD: %s\n", yytext);
}

{PROVISIONAL}+   {      
            printf( "MATRICULA PROVISIONAL: %s\n", yytext);
}

{TURISTICAS}+   {      
            printf( "MATRICULA TURISTICA: %s\n", yytext);
}

{HISTORICO}+   {      
            printf( "MATRICULA HISTORICA: %s\n", yytext);
}
.                       {}
%%

int main( int argc, char ** argv ){
        ++argv, --argc;  /* se salta el nombre del programa */

        if ( argc > 0 )
                yyin = fopen( argv[0], "r" );
        else
                yyin = stdin;
        yylex();
        printf("Encontre %i matriculas\n",  matriculas);

}