#!/bin/sh

yacc -d parse.y

re2c -F -d -c -o a.c scanner.l

gcc -g -o a a.c	y.tab.c -lfl
