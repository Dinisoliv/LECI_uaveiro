grammar Fractions;

program :
    stat* EOF
;

stat :
    'print' expr ';'              #StatPrint
    | expr '->' ID ';'            #StatAssign
    | COMMENT                     #StatComment
;

expr :
    expr '^' Integer              #ExprPower
    | expr op=('*' | ':') expr    #ExprMulDiv
    | expr op=('+' | '-') expr    #ExprAddSub
    | op=('+' | '-') expr         #ExprUnary
    | '(' expr ')' '^' Integer    #ExprPowerParen
    | '(' expr ')'                #ExprParen
    | 'reduce' expr               #ExprReduce
    | Integer '/' Integer         #ExprFraction
    | Integer                     #ExprInteger
    | ID                          #ExprId
;

ID      : [a-zA-Z]+ ;
Integer : [0-9]+ ;
COMMENT : '//' ~[\n]* -> skip ;
NEWLINE : '\r'? '\n' -> skip ;
WS      : [ \t]+ -> skip ;