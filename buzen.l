/* Programming Languages and Compilers Project 2011-2012 */
%{
#include "y.tab.h"  
%}

%option noyywrap

DIGIT [0-9]
LETTER [a-zA-Z]
WORD {LETTER}{DIGIT}*{LETTER}*{DIGIT}*
NUMBER {DIGIT}+

%%

"program"         return PROGRAM;

"procedure"       return PROCEDURE;

"function"        return FUNCTION;

";"               return QM;

"."               return DOT;

"var"             return VAR;

"="               return EQUAL;

":"               return COLON;

","               return COMMA;

"integer"|"boolean" return DATA_TYPES;

"("               return LPAR;

")"               return RPAR;

"if"              return IF;

"while"           return WHILE;

"do"              return DO;

"then"            return THEN;

"else"            return ELSE;

"begin"           return BEGAN;

"end"             return END;

"add"|"sub"|"not"     return UOP;

"="|"<>"|"or"|"and"|"<"|">"|"<="|">="|"+"|"-"|"*"|"div"|"mod" return BOP;

{WORD}            return ID;

{NUMBER}          return INT;
%%

