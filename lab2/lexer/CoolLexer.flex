%{
#include <iostream>
#include <fstream>
#include <cstdio>
#include <string>

#include "Parser.h"
#include "CoolLexer.h"

#undef YY_DECL
#define YY_DECL int CoolLexer::yylex()

%}

white_space       [ \t]*
digit             [0-9]
alpha             [A-Za-z_]
alpha_low         [a-z]
alpha_high        [A-Z]
alpha_num         ({alpha}|{digit})
hex_digit         [0-9a-fA-F]
identifier        {alpha}{alpha_num}*
unsigned_integer  {digit}+
hex_integer       ${hex_digit}{hex_digit}*
exponent          e[+-]?{digit}+
i                 {unsigned_integer}
real              ({i}\.{i}?|{i}?\.{i}){exponent}?
string            \'([^'\n]|\'\')*\'
bad_string        \'([^'\n]|\'\')*

%x COMMENT

%option warn nodefault batch noyywrap c++
%option yylineno
%option yyclass="CoolLexer"

%%

"(*"                 BEGIN(COMMENT);
<COMMENT>[^*)\n]+    { /* skip*/ }
<COMMENT>\n         { lineno++; }
<COMMENT><<EOF>>    Error("EOF in comment");
<COMMENT>"*)"        BEGIN(INITIAL);


class                return TOKEN_KW_CLASS;
else                 return TOKEN_KW_ELSE;
false                return TOKEN_KW_FALSE;
fi                   return TOKEN_KW_FI;
if                   return TOKEN_KW_IF;
in                   return TOKEN_KW_IN;
inherits             return TOKEN_KW_INHERITS;
isvoid               return TOKEN_KW_ISVOID;
let                  return TOKEN_KW_LET;
loop                 return TOKEN_KW_LOOP;
pool                 return TOKEN_KW_POOL;
then                 return TOKEN_KW_THEN;
while                return TOKEN_KW_WHILE;
case                 return TOKEN_KW_CASE;
esac                 return TOKEN_KW_ESAC;
new                  return TOKEN_KW_NEW;
of                   return TOKEN_KW_OF;
not                  return TOKEN_KW_NOT;
true                 return TOKEN_KW_TRUE;
self                 return TOKEN_SELF;
const                return TOKEN_CONST;
self_type            return TOKEN_SELF_TYPE;

"<="|"=<"            return TOKEN_LEQ;
"=>"|">="            return TOKEN_GEQ;
"<>"                 return TOKEN_NEQ;
"="                  return TOKEN_EQ;
".."                 return TOKEN_DOUBLEDOT;

{unsigned_integer}   return TOKEN_UNSIGNED_INTEGER;
{real}               return TOKEN_REAL;
{hex_integer}        return TOKEN_HEX_INTEGER;

{string}             return TOKEN_STRING;
{bad_string}         Error("unterminated string");

{identifier}         return TOKEN_IDENTIFIER;


[*/+\-,^.;:()\[\]]   return yytext[0];

{white_space}        { /* skip spaces */ }
\n                   lineno++;
.                    Error("unrecognized character");

%%

void CoolLexer::Error(const char* msg) const
{
    std::cerr << "Lexer error (line " << lineno << "): " << msg << ": lexeme '" << YYText() << "'\n";
    std::exit(YY_EXIT_FAILURE);
}
