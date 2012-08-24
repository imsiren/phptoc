%{
#include <stdio.h>
#include "scanner.h"
extern int yylex();
void yyerror(char *);
%}
%token	T_OPEN_TAG
%token	T_CLOSE_TAG
%token	T_INCLUDE
%token	T_REQUIRE
%token	T_ECHO
%token	T_UNKNOW
%token	T_STRING
%token 	T_VARIABLE
%token	T_FUNCTION
%token	T_CLASS
%token	T_ABSTRACT
%token	T_FINAL
%token	T_CONST
%token	T_WHITESPACE
%token  T_LNUMBER
%token	T_TOKENS
%token	T_NUM_STRING
%token	T_END
%%
start:
	 T_OPEN_TAG{printf("start\n"); }
	|start statement
;
statement:
	statement_list
;
statement_list:
	 unticked_statement
	|function_declaration_statement
	|class_declaration_statement	
	|constant_declaration ';'
;
unticked_statement:
	common_scalar
;
common_scalar:
	 T_ECHO echo_expr_list ';'
	|T_WHITESPACE {$$=$1;}
	|T_LNUMBER {$$=$1;printf("number:%s",$1);}
	|T_VARIABLE {$$=$1;printf("variable:%s",$1);}
	|T_STRING	{$$=$1;printf("string:%d\n",$1);}
	|T_TOKENS {$$=$1;}
;
function_declaration_statement:
	function is_reference T_STRING '(' paramlist ')' '{' inner_statement_list '}'{}
;
class_declaration_statement:
	class_entry T_STRING 
;
class_entry:
	 T_CLASS {}
	|T_ABSTRACT T_CLASS {}
	|T_FINAL T_CLASS {}
;
constant_declaration:
	 T_CONST T_STRING '=' T_STRING {}
;
is_reference:
	'&'	{$$=$1;}	
;
function:
	T_FUNCTION {$$=$1;}
;
paramlist:

;
inner_statement_list:

;
echo_expr_list:
	echo_expr_list ',' expr {printf("echo :%s\n",$1);}
	|expr			{printf("echo :%s\n",$1);}
;
expr:
	T_STRING {$$=$1;}
;
%%

void yyerror(char *msg){
	printf("error:%s\n",msg);
}
