
/* The first section of a bison file contains:
 *    1. A code section for includes and other arbitrary C code. Copied to the parser verbatim
 *    2. Definition of the yylval union
 *    3. Definition of the tokens
 *    4. Precedence directives
 *    5. The start token
 *    6. Parser options
 */

/* Code section */
%{


#include <stdio.h>
#include <stdlib.h>
#include "tree.h"

extern PROGRAM *my_prog;
// Reference to the line number generated by the scanner
extern int yylineno;
// Reference to the yylex function to quiet a compiler warning
int yylex();

// The yyerror function is called on any syntax error. When using %error-verbose, this function
// takes a single argument (a string) which contains a detailed explanation of the error.
// Otherwise it takes no arguments and it is up to the user to format the error using a minimal
// description provided in yytext.
void yyerror(const char *s) {
	fprintf(stderr, "Error: (line %d) %s\n", yylineno, s);
	exit(1);
}
%}


/* The union directive defines the yylval union used for associating (a) terminals (tokens)
 * returned by flex with additional scanning data (such as identifier/constant values); and
 * optionally (b) non-terminals (variables in productions) with AST information if any.
 */
%union {
	int intval;
	char *identifier;
    float floatval;
    char *strval;
    int boolval;
    char runeval;
    TYPE *typeval;
    EXP *expval;
    STATEMENT *stmtval;
    DECLARATION *decval;
    PROGRAM *progval;
    FUNCTION *funcval;
}

/* Token directives define the token types to be returned by the scanner (excluding character
 * tokens). Each token definition takes [optionally, a reference to the associated field in the
 * yylval union] and an identifier. Multiple tokens can eb defined per directive by using a list
 * of identifiers separated by spaces.
 */
%type <progval> prgrm
%type <funcval> funcdef 
%type <decval> progdefs topdecl dec blockidents decdistributed typedec typedistributed vardec parameters parameter
%type <stmtval> stmts stmt ifstmt elsestmt switchstmt switchbody forstmt asnexps returnstmt simplestmt
%type <expval> exp exps idents
%type <typeval> type opttype

%token tINT
%token tFLOAT
%token tSTRING
%token tBOOL
%token tRUNE
%token <intval> tINTLITERAL
%token <floatval> tFLOATLITERAL
%token <strval> tSTRINGLITERAL
%token <strval> tRAWSTRINGLITERAL
%token <boolval> tBOOLLITERAL
%token <runeval> tRUNELITERAL
%token <identifier> tIDENTIFIER
%token tTYPE
%token <identifier> tSTRUCT
%token tFUNC
%token tGEQ
%token tLEQ
%token tNEQ
%token tEQ
%token tLEFTSHIFT
%token tRIGHTSHIFT
%token tANDNOT
%token tINCREMENT
%token tDECREMENT
%token tGO
%token tGOTO
%token tDEFER
%token tFALLTHROUGH
%token tVAR
%token tPRINT
%token tPRINTLN
%token tBREAK
%token tCONTINUE
%token tAPPEND
%token tLEN
%token tCAP
%token tREAD
%token tWHILE
%token tIF
%token tELSE
%token tFOR
%token tSWITCH
%token tCASE
%token tDEFAULT
%token tRETURN
%token tCOLONASSIGN
%token tORASSIGN
%token tANDASSIGN
%token tAND
%token tOR
%token tPACKAGE
%token tCHAN
%token tCONST
%token tSELECT
%token tIMPORT
%token tRANGE
%token tPLUSASSIGN
%token tMINUSASSIGN
%token tTIMESASSIGN
%token tDIVASSIGN
%token tMODASSIGN
%token tPOWASSIGN
%token tAMPPOWASSIGN
%token tDOTS
%token tINTERFACE
%token tLSHIFTASSIGN
%token tRSHIFTASSIGN
%token tLESSMINUS
%token tMAP

/* Precedence directives resolve grammar ambiguities by breaking ties between shift/reduce
 * operations. Tokens are grouped into precendence levels, with lower precedence coming first
 * and then higher precedence in later directives. Tokens specified in the same directive have
 * the same precedence. Ties at the same level are broken using either %left or %right, which
 * denote left-associative and right-associative respectively.
 */



%left tOR
%left tAND tANDNOT
%left '|' '^'
%left '&'
%left tLEFTSHIFT tRIGHTSHIFT
%left tEQ tNEQ 
%left tGEQ tLEQ '>' '<'
%left '+' '-'
%left '*' '/' '%' 
%left UNARY
%left '.' // struct field access
%left '['
%left '('

/* Unused tokens, only for precedence directives */
%token UNARY 

/* Start token (by default if this is missing it takes the first production */
%start prgrm

/* Generate the yylloc structure used for storing line numbers with tokens */
%locations
/* Generate detailed error messages */
%error-verbose


/* For making the AST constructor work */
%code requires
{
	#include "tree.h"
}

/* The second section of a bison file contains the productions. Note that rules with the
 * same LHS may be joined together and separated with a pipe.
 */
%% 

/* Represents the entire program. Makes sure there is only one package dec */
prgrm           : tPACKAGE tIDENTIFIER ';' progdefs {$$ = makePROG($2, $4); my_prog = $$;}
                ;
/*list of declarations and function declarations*/
progdefs        : {$$ = NULL;}
                | progdefs topdecl {if($2 != NULL){$$ = $2; $$->next = $1;} else{ $$ = $1;}}
                ;

topdecl         : dec { $$ = $1;}
                | funcdef { $$ = makeDECL_fn(NULL, $1, yylineno); }
                ;

/* Expressions of all kinds. */
exp             : '+' exp %prec UNARY {$$ = makeEXP_pos($2);}
                | '-' exp %prec UNARY {$$ = makeEXP_neg($2);}
                | '!' exp %prec UNARY {$$ = makeEXP_not($2);} 
                | '^' exp %prec UNARY {$$ = makeEXP_uxor($2);}
                | exp '<' exp {$$ = makeEXP_lt($1, $3);}
                | exp '>' exp {$$ = makeEXP_gt($1, $3);}
                | exp tEQ exp {$$ = makeEXP_eq($1, $3);}
                | exp tNEQ exp {$$ = makeEXP_neq($1, $3);}
                | exp tGEQ exp {$$ = makeEXP_geq($1, $3);}
                | exp tLEQ exp {$$ = makeEXP_leq($1, $3);}
                | exp tAND exp {$$ = makeEXP_and($1, $3);}
                | exp tOR exp  {$$ = makeEXP_or($1, $3);}
                | exp '+' exp  {$$ = makeEXP_plus($1, $3);}
                | exp '-' exp  {$$ = makeEXP_minus($1, $3);}
                | exp '|' exp  {$$ = makeEXP_bor($1, $3);}
                | exp '^' exp  {$$ = makeEXP_xor($1, $3);}
                | exp '*' exp {$$ = makeEXP_times($1, $3);}
                | exp '/' exp {$$ = makeEXP_div($1, $3);}
                | exp '%' exp {$$ = makeEXP_mod($1, $3);}
                | exp tLEFTSHIFT exp {$$ = makeEXP_lshift($1, $3);}
                | exp tRIGHTSHIFT exp {$$ = makeEXP_rshift($1, $3);}
                | exp '&' exp {$$ = makeEXP_band($1, $3);}
                | exp tANDNOT exp {$$ = makeEXP_andnot($1, $3);}
                | '(' exp ')' {$$ = makeEXP_par($2);}
                | tINTLITERAL {$$ = makeEXP_int($1);}
                | tFLOATLITERAL {$$ = makeEXP_float($1);}
                | tBOOLLITERAL {$$ = makeEXP_bool($1);}
                | tRUNELITERAL {$$ = makeEXP_rune($1);}
                | tSTRINGLITERAL {$$ = makeEXP_str($1);}
		        | tRAWSTRINGLITERAL {$$ = makeEXP_rawstr($1);}
                | tAPPEND '(' exp ',' exp ')' {$$ = makeEXP_append($3, $5);}
                | tLEN '(' exp ')' {$$ = makeEXP_len($3);}
                | tCAP '(' exp ')' {$$ = makeEXP_cap($3);}
                | exp '.' tIDENTIFIER {EXP *id = makeEXP_id($3); $$ = makeEXP_invoc($1, id);}
                | exp '[' exp ']' {$$ = makeEXP_element($1, makeEXP_index($3));}
                | exp '(' exps ')' { $$ = makeEXP_func_access($1, 0, makeDECL_fnCallArgs($3)); }
				| exp '(' ')' { $$ = makeEXP_func_access($1, 0, makeDECL_fnCallArgs(NULL)); }
                | tIDENTIFIER {$$ = makeEXP_id($1);}
                ;

/* an arbitrily long list of expressions, separated by commas */
exps            : exps ',' exp {$$ = makeEXP_expblock($3, $1);}
                | exp {$$ = makeEXP_expblock($1, NULL);}
                ;

/* an arbitrily long list of identifiers, separated by commas */
idents          : idents ',' tIDENTIFIER %prec UNARY {$$ = makeEXP_idblock($3, $1);} 
                | tIDENTIFIER ',' tIDENTIFIER {$$ = makeEXP_idblock($3, makeEXP_idblock($1, NULL));}
                ;

/* a block of lists of identifiers. Used in the distributed type () statements. */
blockidents     : blockidents tIDENTIFIER type ';' {$$ = makeDECL_norhs(1, $2, $3, yylineno); $$->next = $1;}
		        | blockidents idents type ';' {$$ = makeDECL_blocknorhs(yylineno, $2, $3); $$->next = $1;}
                | {$$ = NULL;}
                ;

/* variable declarations */
dec             : tVAR vardec {$$ = $2;}
                | tVAR '(' decdistributed ')' ';' {$$ = $3;}
                | typedec ';' {$$ = $1;}
                ;

vardec          : idents type ';' {$$ = makeDECL_blocknorhs(yylineno, $1, $2);}
                | idents opttype '=' exps ';' {$$ = makeDECL_block(yylineno, $1, $2, $4);}
                | tIDENTIFIER type ';' {$$ = makeDECL_norhs(1, $1, $2, yylineno);}
                | tIDENTIFIER opttype '=' exp ';' {$$ = makeDECL(1, $1, $2, $4, yylineno);}
                ;
/* A block of things put into a distributed var () statement */
decdistributed  : decdistributed vardec {$$ = $2; $$->chain = $1;}
                | {$$ = NULL;}
                ;

/* Used for declaring user-defined types */
typedec         : tTYPE tIDENTIFIER type {$$ = makeDECL_type($2, $3, yylineno);}
                | tTYPE '(' typedistributed ')' {$$ = $3;}
                ;

/* Used for declaring user defined types with the distributed type () syntax */
typedistributed : typedistributed tIDENTIFIER type ';' { $$ = makeDECL_type($2, $3, yylineno); $$->chain = $1;}
                | {$$ = NULL;}
                ;

/* function definitions */
funcdef         : tFUNC tIDENTIFIER '(' parameters ')' opttype '{' stmts '}' ';'
                    {$$ = makeFCTN(yylineno, $2, 0, $4, $6, $8);}
		        |  tFUNC tIDENTIFIER '(' ')' opttype '{' stmts '}' ';'
                    {$$ = makeFCTN(yylineno, $2, 0, NULL, $5, $7);}
                ;


/* List of parameters of function declaration signatures */
parameters      : parameters ',' parameter {$$ = $3; findBottomDECL($$)->next = $1;}
                | parameter {$$ = $1;}
                ;

parameter       : tIDENTIFIER type {$$ = makeDECL_norhs(1, $1, $2, yylineno);}
                | idents type {$$ = makeDECL_blocknorhs(yylineno, $1, $2);}
                ;

opttype         : type {$$ = $1;}
                | {$$ = makeTYPE(nilType, 0, " ", NULL);}
                ;

/* Defines the various kinds of types that can be used.*/
type            : tIDENTIFIER {$$ = makeTYPE(baseType, 1, $1, NULL);}
                | '[' ']' type {$$ = makeTYPE(sliceType, 0, NULL, $3);}
                | '[' tINTLITERAL ']' type {$$ = makeTYPE(arrayType, $2, NULL, $4);}
                | tSTRUCT '{' blockidents '}' {$$ = makeTYPE_struct(0, $1, $3 );}
                | '(' type ')' {$$ = $2;}
                ;

/* A block of statements */
stmts           : stmts stmt {$$ = $2; $$->next = $1;}
                | {$$ = NULL;}
                ;

/* Defines the kinds of statements that can be used in any context 
A potential issue is having returnstmt in here. Should you be able to return from anywhere?*/
stmt            : simplestmt ';' {$$ = $1;}
                | tPRINT '(' exps ')' ';' {$$ = makeSTMT_print(yylineno, $3, 0);}
                | tPRINTLN '(' exps ')' ';' {$$ = makeSTMT_print(yylineno, $3, 1);}
				| tPRINT '(' ')' ';' {$$ = makeSTMT_print(yylineno, NULL, 0 );}
				| tPRINTLN '(' ')' {$$ = makeSTMT_print(yylineno, NULL, 1);}
                | tBREAK ';' {$$ = makeSTMT_break(yylineno);}
                | tCONTINUE ';' {$$ = makeSTMT_continue(yylineno);}
                | '{' stmts '}' ';' {$$ = makeSTMT_block(yylineno, $2);}
                | ifstmt {$$ = $1;}
                | switchstmt {$$ = $1;}
                | forstmt {$$ = $1;}
                | returnstmt {$$ = $1;}
                | dec {$$ = makeSTMT_decl(yylineno, $1);}
                | ';' {$$ = makeSTMT_empty();}
                ;

/* A subset of statements that can be used in certain extra contexts,
such as before the conditional expressions of if statements */
simplestmt      : exp  {$$ = makeSTMT_exp(yylineno, $1);} 
                | exp tDECREMENT  {EXP *ident = $1; $$ = makeSTMT_decrement(yylineno, ident);}
                | exp tINCREMENT  {EXP *ident = $1; $$ = makeSTMT_increment(yylineno, ident);}
                | asnexps {$$ = $1;}
                ;

/* Defines all kinds of if statement, with or without a simplestmt before the conditional */
ifstmt          : tIF exp '{' stmts '}' elsestmt {$$ = makeSTMT_if(yylineno, $2, NULL, $4, $6);}
                | tIF simplestmt ';' exp '{' stmts '}' elsestmt {$$ = makeSTMT_if(yylineno, $4, $2, $6, $8);}
                | tIF ';' exp '{' stmts '}' elsestmt {$$ = makeSTMT_if(yylineno, $3, NULL, $5, $7);}
                ;

elsestmt        : tELSE tIF exp '{' stmts '}' elsestmt {$$ = makeSTMT_elif(yylineno, $3, NULL, $5, $7);}
                | tELSE tIF simplestmt ';' exp '{' stmts '}' elsestmt {$$ = makeSTMT_elif(yylineno, $5, $3, $7, $9);}
                | tELSE tIF ';' exp '{' stmts '}' elsestmt {$$ = makeSTMT_elif(yylineno, $4, NULL, $6, $8);}
                | tELSE '{' stmts '}' ';' {$$ = makeSTMT_else(yylineno, $3);}
                | ';' {$$ = NULL;}
                ;
/* Defines switch statements */
switchstmt      : tSWITCH '{' switchbody '}' ';' {$$ = makeSTMT_switch(yylineno, NULL, NULL, $3);}
                | tSWITCH simplestmt ';' '{' switchbody '}' ';' {$$ = makeSTMT_switch(yylineno, NULL, $2, $5);}
                | tSWITCH ';' '{' switchbody '}' ';' {$$ = makeSTMT_switch(yylineno, NULL, NULL, $4);}
                | tSWITCH exp '{' switchbody '}' ';' {$$ = makeSTMT_switch(yylineno, $2, NULL, $4);}
                | tSWITCH simplestmt ';' exp '{' switchbody '}' ';' {$$ = makeSTMT_switch(yylineno, $4, $2, $6);}
                ;

/* Defines the body of a switch statement Handling expression list as cases?*/
switchbody      : switchbody tCASE exps ':' stmts {$$ = makeSTMT_case(yylineno, $3, $5); $$->next = $1;}
                | switchbody tDEFAULT ':' stmts {$$ = makeSTMT_case(yylineno, NULL, $4); $$->next = $1;}
                | {$$ = NULL;}
                ;

/* Defines all three supported kinds of support statements */
forstmt         : tFOR '{' stmts '}' ';' {$$ = makeSTMT_while(yylineno, NULL, $3);}
                | tFOR exp '{' stmts '}' ';' {$$ = makeSTMT_while(yylineno, $2, $4);}
                | tFOR simplestmt ';' exp ';' simplestmt '{' stmts '}' ';' {$$ = makeSTMT_for(yylineno, $2, $4, $8, $6);}
                | tFOR ';' exp ';' simplestmt '{' stmts '}' ';' {$$ = makeSTMT_for(yylineno, NULL, $3, $7, $5);}
                | tFOR simplestmt ';' exp ';' '{' stmts '}' ';' {$$ = makeSTMT_for(yylineno, $2, $4, $7, NULL);}
                | tFOR ';' exp ';' '{' stmts '}' ';' {$$ = makeSTMT_for(yylineno, NULL, $3, $6, NULL);}
                | tFOR ';' ';' '{' stmts '}' ';' {$$ = makeSTMT_for(yylineno, NULL, makeEXP_empty(), $5, NULL);}
                | tFOR simplestmt ';' ';' '{' stmts '}' ';' {$$ = makeSTMT_for(yylineno, $2, makeEXP_empty(), $6, NULL);}
                | tFOR ';' ';' simplestmt '{' stmts '}' ';' {$$ = makeSTMT_for(yylineno, NULL, makeEXP_empty(), $6, $4);}
                | tFOR simplestmt ';' ';' simplestmt '{' stmts '}' ';' {$$ = makeSTMT_for(yylineno, $2, makeEXP_empty(), $7, $5);}
                ;

/* Defines return statements */
returnstmt      : tRETURN ';' {$$ = makeSTMT_return(yylineno, NULL);}
                | tRETURN exp ';' {$$ = makeSTMT_return(yylineno, $2);}
                ;


/* Defines the kind of valid assignment expressions.
Again, we need to account for an equal number of idents and exps on either side.
We also need to account for the operand-equals construction. */
asnexps         : exps '=' exps {$$ = makeSTMT_blockassign(yylineno, $1, $3);}
                | exps tCOLONASSIGN exps {$$ = makeSTMT_blockqassign(yylineno, $1, $3);}
                | exp tPLUSASSIGN exp %prec UNARY {EXP *id = $1; 
                    EXP *newExp = makeEXP_plus(id, $3);  $$ = makeSTMT_assmt(yylineno, id, newExp);}
                | exp tMINUSASSIGN exp %prec UNARY {EXP *id = $1; 
                    EXP *newExp = makeEXP_minus(id, $3);  $$ = makeSTMT_assmt(yylineno, id, newExp);}
                | exp tTIMESASSIGN exp %prec UNARY {EXP *id = $1; 
                    EXP *newExp = makeEXP_times(id, $3);  $$ = makeSTMT_assmt(yylineno, id, newExp);}
                | exp tDIVASSIGN exp %prec UNARY {EXP *id = $1; 
                    EXP *newExp = makeEXP_div(id, $3);  $$ = makeSTMT_assmt(yylineno, id, newExp);}
                | exp tMODASSIGN exp %prec UNARY {EXP *id = $1; 
                    EXP *newExp = makeEXP_mod(id, $3);  $$ = makeSTMT_assmt(yylineno, id, newExp);}
                | exp tANDASSIGN exp %prec UNARY {EXP *id = $1; 
                    EXP *newExp = makeEXP_band(id, $3);  $$ = makeSTMT_assmt(yylineno, id, newExp);}
                | exp tORASSIGN exp %prec UNARY {EXP *id = $1; 
                    EXP *newExp = makeEXP_bor(id, $3);  $$ = makeSTMT_assmt(yylineno, id, newExp);}
                | exp tPOWASSIGN exp %prec UNARY {EXP *id = $1; 
                    EXP *newExp = makeEXP_xor(id, $3);  $$ = makeSTMT_assmt(yylineno, id, newExp);}
                | exp tAMPPOWASSIGN exp %prec UNARY {EXP *id = $1; 
                    EXP *newExp = makeEXP_andnot(id, $3);  $$ = makeSTMT_assmt(yylineno, id, newExp);}
                | exp tLSHIFTASSIGN exp %prec UNARY {EXP *id = $1; 
                    EXP *newExp = makeEXP_lshift(id, $3);  $$ = makeSTMT_assmt(yylineno, id, newExp);}
                | exp tRSHIFTASSIGN exp %prec UNARY {EXP *id = $1; 
                    EXP *newExp = makeEXP_rshift(id, $3);  $$ = makeSTMT_assmt(yylineno, id, newExp);}
                ;



