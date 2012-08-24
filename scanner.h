/*
 * =====================================================================================
 *
 *       Filename:  scanner.h
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  08/23/2012 10:52:24 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *   Organization:  
 *
 * =====================================================================================
 */
enum{
	yycINITIAL,
	yycST_IN_SCRIPTING,
};

struct _scanner{
	int fd;
	char *yy_text,*yy_marker,*yy_limit,*yy_cursor; 
	int yy_leng,yy_state;
};
struct _scanner sc_globals;
int yylex();
int scan(char*);
