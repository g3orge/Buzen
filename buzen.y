%{
#include <stdio.h>
void yyerror(char *); 
extern FILE *yyin;								
extern FILE *yyout;								
%}

%token PROGRAM PROCEDURE FUNCTION QM DOT VAR ID COLON DATA_TYPES COMMA
%token BEGAN END THEN ELSE EQUAL WHILE DO IF
%token LPAR RPAR BOP UOP INT

%%

program:                PROGRAM ID QM block DOT ;

block:                  local_definition compound_statement ;

local_definition:       variable_definition local_definition
                      | procedure_definition local_definition
                      | function_definition local_definition
                      | ;

variable_definition:    VAR def_some_variables QM def_wrap ;

def_wrap:               def_some_variables QM def_wrap
                      | ;

def_some_variables:     ID id_wrap COLON DATA_TYPES ;

id_wrap:                COMMA ID id_wrap 
                      | ;

procedure_definition:   procedure_header block QM ;

procedure_header:       PROCEDURE ID formal_parameters QM ;

function_definition:    function_header block QM ;

function_header:        FUNCTION ID formal_parameters COLON DATA_TYPES QM ;

formal_parameters:      LPAR formal_parameter f_wrap RPAR 
                      | ;

f_wrap:                 QM formal_parameter  f_wrap
                      | ;

formal_parameter:       ID id_wrap COLON DATA_TYPES ;

statement:             assignment
                      | if_statement
                      | while_statement
                      | proc_func_call
                      | compound_statement 
                      | ;

assignment:             ID COLON EQUAL expression ;

if_statement:           IF  a ;

a:                      expression THEN statement 
                      | expression THEN statement  ELSE statement ;

while_statement:        WHILE expression DO statement ;

proc_func_call:         ID 
                      | ID LPAR actual_parameters RPAR ;

actual_parameters:      expression expr_wrap ;

expr_wrap:              COMMA expression expr_wrap 
                      | ;

compound_statement:     BEGAN b ;

b:                      END 
                      | statement stat_wrap END ;

stat_wrap:              QM statement stat_wrap
                      | ;

expression:             UOP expression wrapper
                      | proc_func_call wrapper
                      | LPAR expression RPAR wrapper
                      | INT wrapper
                      | ID wrapper ;

wrapper:                BOP expression wrapper
                      | ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}				

int main ( int argc, char **argv  ) {
  if (argc > 1)
        yyin = fopen(argv[1], "r");
  else
        yyin = stdin;
  yyout = fopen ("output", "w");	
  yyparse ();	    
  return 0;
  } 					

