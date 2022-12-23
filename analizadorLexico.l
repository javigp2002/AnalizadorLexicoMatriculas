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
EUROPEAS {DIGITOS}[ -]*{CONSONANTESEUROPEAS}
FUERZAESTADO ("PGC"|"CNP"|"ET"|"EA"|"FN"|"E"|"CGPC")[ -]*{DIGITOS}[ -]*[B-DF-HJ-NPR-TV-Z]
CICLOMOTOR "C"{DIGITOS}{CONSONANTESEUROPEAS}
DIPLOMATICAS ("CD"|"CC"|"TA"|OI)[ -]*[0-9]{2}[ -]*[0-9]{3}
REMOLQUES "R"[ -]*{DIGITOS}[ -]*{CONSONANTESEUROPEAS}
QUADS "E"[ -]*{DIGITOS}[ -]*{CONSONANTESEUROPEAS}
PROVISIONAL ("P"|"S"|"B")[ -]*{DIGITOS}[ -]*{CONSONANTESEUROPEAS}
TURISTICAS "T"[ -]*{DIGITOS}[ -]*{CONSONANTESEUROPEAS}
HISTORICO "H"[ -]*{DIGITOS}[ -]*{CONSONANTESEUROPEAS}

%%

{PROVINCIAL}+   {
            printf( "MATRICULA PROVINCIAL: %s\n", yytext);
            }



{EUROPEAS}   {
        matriculas++;
       /*char * x ;
        x = yytext;
        x[strlen(x) - 1] = '\0';*/
            printf( "MATRICULA EUROPEA ACTUAL: %s\n", yytext);
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