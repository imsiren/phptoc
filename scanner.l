#include <stdio.h>
#include "scanner.h"
#include "y.tab.h"

#define YYCTYPE	char
#define STATE(name)	yyc##name
#define BEGIN(n)	YYSETCONDITION(STATE(n))
#define LANG_SCNG(v)	(sc_globals.v)
#define SCNG	LANG_SCNG
#define YYGETCONDITION()	SCNG(yy_state)
#define YYSETCONDITION(s)	SCNG(yy_state)=s
#define YYCURSOR		SCNG(yy_cursor)
#define YYFILL(n)
#define YYLIMIT			SCNG(yy_limit)
#define YYMARKER		SCNG(yy_marker)
#define yytext			SCNG(yy_text)
#define yyleng			SCNG(yy_leng)
#define YYDEBUG(s,c) 	printf("debug:%d :%c\n",s,c)

int scan(char *p){
	SCNG(yy_text)=YYCURSOR;
/*!re2c
LNUM    [0-9]+
DNUM    ([0-9]*"."[0-9]+)|([0-9]+"."[0-9]*)
EXPONENT_DNUM   (({LNUM}|{DNUM})[eE][+-]?{LNUM})
HNUM    "0x"[0-9a-fA-F]+
LABEL   [a-zA-Z0-9_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*
WHITESPACE [ \n\r\t]+
TABS_AND_SPACES [ \t]*
TOKENS [;:,.\[\]()|^&+-/*=%!~$<>?@]
ANY_CHAR [^]
END	[\000]
NEWLINE ("\r"|"\n"|"\r\n")		
	<INITIAL>"<?php"([ \t]|{NEWLINE})? {
		BEGIN(ST_IN_SCRIPTING);
		return T_OPEN_TAG;
	}		
	<ST_IN_SCRIPTING>"echo" {

		return T_ECHO;
	}
	<ST_IN_SCRIPTING>{LNUM} {
		return T_LNUMBER;
	}
	<ST_IN_SCRIPTING>[0]|([1-9][0-9]*) {
		return T_NUM_STRING;
	}
	<ST_IN_SCRIPTING>"$"{LABEL} {
		return T_STRING;
	}
	<ST_IN_SCRIPTING>{WHITESPACE} {
		return T_WHITESPACE;
	}
	<ST_IN_SCRIPTING>{ANY_CHAR} {
		return T_UNKNOW;
	}
	<ST_IN_SCRIPTING>{TOKENS} {
		return T_TOKENS;
	}
	<ST_IN_SCRIPTING>{END} {
		return T_END;
	}
	<ST_IN_SCRIPTING>"?>" {
		return T_CLOSE_TAG;
	}

*/
}
int yylex(){
	int token;
	char *p=YYCURSOR;
	while(token=scan(p)){
		return token;
	}
}
int main (int argc,char ** argv){
	BEGIN(INITIAL);
	YYCURSOR=argv[1];
	yyparse();
	return 0;
}
