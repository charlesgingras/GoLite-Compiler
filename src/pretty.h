#ifndef PRETTY_H
#define PRETTY_H

#include "tree.h"

void prettyPROG(PROGRAM *my_prog);
void prettyFctn(FUNCTION *fn, int t);
void prettyFctnDecl(DECLARATION *sd, int printComma, int t);
void prettyType(TYPE *t, int tabs);
void prettyDecl(DECLARATION  *d, int t, int isInStruct);
void prettySDecl(STATEMENT  *d);
void prettySDeclId(STATEMENT  *d);
void prettySDeclVal(STATEMENT *d);
void prettySDeclFn(EXP *s);
void prettyStmt(STATEMENT *s, int t);
void prettyAssign(STATEMENT *s, int t);
void prettyBlock(STATEMENT *s, int t);
void prettyIf(STATEMENT *s, int t);
void prettyElif(STATEMENT *s,int t);
void prettyElse(STATEMENT *s,int t);
void prettyFor(STATEMENT *s, int t);
void prettyWhile(STATEMENT *s, int t);
void prettyPrintS(STATEMENT *s, int t);
void prettyReturn(STATEMENT *s, int t);
void prettyBreak(int t);
void prettyContinue(int t);
void prettySwitch(STATEMENT *s, int t);
void prettyCase(STATEMENT *s, int t);
void prettyExpBlock(EXP *e);
void prettyExp(EXP *e);
void prettyStmtFn(STATEMENT *s);

//prints n tabs
void prettyTabs(int n);
#endif