grammar Numbers;

program :
    line* EOF
;

line :
    INT '-' WORD NEWLINE
;

INT    : [0-9]+ ;
WORD   : [a-zA-Z]+ ;
NEWLINE: '\r'? '\n' ;
WS     : [ \t]+ -> skip ;