grammar StrLang;

program :
    stat* EOF
;

stat :
    'print' expr NEWLINE    #StatPrint
    | ID ':' expr NEWLINE   #StatAssign
    | NEWLINE               #StatEmpty
;

expr :
    expr '/' STRING '/' STRING    #ExprReplace
    | expr '+' expr               #ExprConcat
    | expr '-' expr               #ExprRemove
    | 'trim' expr                 #ExprTrim
    | 'input' '(' STRING ')'      #ExprInput
    | '(' expr ')'                #ExprParen
    | STRING                      #ExprString
    | ID                          #ExprId
;

ID      : [a-zA-Z][a-zA-Z0-9]* ;
STRING  : '"' ~["\r\n]* '"' ;
NEWLINE : '\r'? '\n' ;
WS      : [ \t]+ -> skip ;
COMMENT : '//' ~[\n]* -> skip ;
