%{
/* se necesita esto para la llamada a atof() más abajo */
#include <math.h>
#include <stdio.h>
#include <string.h>

int matriculas = 0;

int compruebaSintaxis(char * matricula) {
        int correcto = 0;

        if (matricula[strlen(matricula) - 1] != '\0')
                matricula[strlen(matricula) - 1] = '\0';

        if (matricula[-1] == ' ' || matricula[-1] == '\b' || matricula[-1] == '"') {
                correcto = 1;
                matriculas++;
        }

        return correcto;
}

%}

/*[^A-Za-z0-9]? */
DIGITOS   [0-9]{4}
CONSONANTESEUROPEAS [B-DF-HJ-NPR-TV-Z]{3}
ID       [a-z][a-z0-9]*
FIN_PALABRA ([^A-Za-z0-9]|"\0")
FINAL    {DIGITOS}[ -]*{CONSONANTESEUROPEAS}{FIN_PALABRA}

PROVINCIAL [A-Z][A-Z]?{DIGITOS}[A-Z]{2}{FIN_PALABRA}
EUROPEAS (\b)?{FINAL}
FUERZAESTADO  (\b)?("PGC"|"CNP"|"ET"|"EA"|"FN"|"E"|"CGPC")[ -]*{DIGITOS}[ -]*[B-DF-HJ-NPR-TV-Z]{FIN_PALABRA}
CICLOMOTOR  (\b)?"C"[ -]*{FINAL}
DIPLOMATICAS  (\b)?("CD"|"CC"|"TA"|OI)[ -]*[0-9]{2}[ -]*[0-9]{3}{FIN_PALABRA}
REMOLQUES  (\b)?"R"[ -]*{FINAL}
QUADS  (\b)?"E"[ -]*{FINAL}
PROVISIONAL  (\b)?("P"|"S"|"B")[ -]*{FINAL}
TURISTICAS  (\b)?"T"[ -]*{FINAL}
HISTORICO  (\b)?"H"[ -]*{FINAL}

%%

{EUROPEAS}   {
        char * x ;
        x = yytext;

        if(compruebaSintaxis(x) == 1)
                printf("MATRICULA EUROPEA MODERNA: %s\n", x);
}

{FUERZAESTADO}   {
        char * x ;
        x = yytext;
        
        if(compruebaSintaxis(x) == 1)
                printf("MATRICULA FUERZAS DEL ESTADO: %s\n", x);
        else    
                printf("FUERZAS DEL ESTADO NO PASÓ EL TEST.\n");
}

{CICLOMOTOR}   {  
        char * x ;
        x = yytext;

        if(compruebaSintaxis(x) == 1)
                printf("MATRICULA CICLOMOTOR: %s\n", x);
}

{DIPLOMATICAS}   {   
        char * x ;
        x = yytext;

        if(compruebaSintaxis(x) == 1)
                printf("MATRICULA DIPLOMATICA: %s\n", x);
}

{REMOLQUES}   {    
        char * x ;
        x = yytext;

        if(compruebaSintaxis(x) == 1)
                printf("MATRICULA REMOLQUES: %s\n", x);
}

{QUADS}   {      
        char * x ;
        x = yytext;

        if(compruebaSintaxis(x) == 1)
                printf("MATRICULA QUAD: %s\n", x);

}

{PROVINCIAL}   {
        char * x ;
        x = yytext;

       if(compruebaSintaxis(x) == 1)
                printf("MATRICULA PROVINCIAL: %s\n", x);
}

{PROVISIONAL}   {  
        char * x ;
        x = yytext;

        if(compruebaSintaxis(x) == 1)
                printf("MATRICULA PROVISIONAL: %s\n", x);
}

{TURISTICAS}   {    
        char * x ;
        x = yytext;

        if(compruebaSintaxis(x) == 1)
                printf("MATRICULA TURISTICA: %s\n", x);
}

{HISTORICO}   {    
        char * x ;
        x = yytext;

        if(compruebaSintaxis(x) == 1)
                printf("MATRICULA HISTORICO: %s\n", x);
}
.                       {}
%%

int main( int argc, char ** argv ) {
        ++argv, --argc;  /* se salta el nombre del programa */

        if ( argc > 0 )
                yyin = fopen( argv[0], "r" );
        else
                yyin = stdin;
        yylex();

        printf("Encontre %i matriculas\n",  matriculas);
}