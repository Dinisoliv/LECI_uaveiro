grammar Questions;

program :
    question* EOF
;

question:
    ID '(' STRING ')' '{' answer+ '}'
;

answer:
    STRING ':' Integer ';'
;

ID      : [a-bA-Z];
Integer : [0-9]+;
STRING  : '"' ~["\r\n]* '"' ;
COMMENT : '#' ~[\n]* -> skip ;
NEWLINE : '\r'? '\n' -> skip ;
WS      : [ \t]+ -> skip ;
