grammar CalculatorVars;

program :
    stat* EOF
;

stat :
    assignment NEWLINE    #StatAssignment
    | expr NEWLINE        #StatExpr
    | NEWLINE             #StatEmpty
;

assignment :
    ID '=' expr
;

expr :
    op=('+' | '-') expr                   #ExprUnary
    | expr op=('*' | '/' | '%') expr      #ExprMultDivMod
    | expr op=('+' | '-') expr            #ExprAddSub
    | '(' expr ')'                        #ExprParent
    | Integer                             #ExprInteger
    | ID                                  #ExprId
;

ID      : [a-zA-Z]+ ;
Integer : [0-9]+ ;
NEWLINE : '\r'? '\n' ;
WS      : [ \t]+ -> skip ;
COMMENT : '#' ~[\n]* -> skip ;