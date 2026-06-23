grammar FracLang;

program :
    stat* EOF
;

stat :
    'display' expr ';'      #StatDisplay
    | ID '<=' expr ';'      #StatAssign
    | NEWLINE               #StatEmpty
;

expr :
    op=('+' | '-') expr             #ExprUnary
    | expr op=('*' | ':') expr      #ExprMulDiv
    | expr op=('+' | '-') expr      #ExprAddSub
    | '(' expr ')'                  #ExprParen
    | 'read' STRING                 #ExprRead
    | INT '/' INT                   #ExprFraction
    | INT                           #ExprInteger
    | ID                            #ExprId
;

ID      : [a-z]+ ;
INT     : [0-9]+ ;
STRING  : '"' ~["\r\n]* '"' ;
NEWLINE : '\r'? '\n' -> skip ;
WS      : [ \t]+ -> skip ;
COMMENT : '--' ~[\n]* -> skip ;