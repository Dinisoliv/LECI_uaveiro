grammar Vector;

// ─── Parser Rules ────────────────────────────────────────────────────────────

program : stat* EOF ;

stat
    : expr '->' ID ';'    # Assign    // e.g.  [1,2] -> v1;   5.5 -> e1;
    | 'show' expr ';'     # Show      // e.g.  show v1;   show 3;
    ;

// Operator precedence: alternatives listed FIRST = HIGHER priority.
// Non-left-recursive alternatives (unary, atoms) are always "primary".
//
// Priority order (descending):  unary prefix > * / . > + -
expr
    : op=('+' | '-') expr                      # Unary       // prefix +/-
    | expr op=('*' | '.') expr                 # MulDot      // multiply / dot
    | expr op=('+' | '-') expr                 # AddSub      // add / subtract
    | '(' expr ')'                             # Paren       // grouping
    | '[' NUMBER (',' NUMBER)* ']'             # VecLit      // vector literal
    | NUMBER                                   # ScalarLit   // scalar literal
    | ID                                       # Var         // variable
    ;

// ─── Lexer Rules ─────────────────────────────────────────────────────────────

// Integer or fixed-point real  (Nota 5)
NUMBER  : [0-9]+ ('.' [0-9]+)? ;

// Lowercase letters + digits, cannot start with digit  (Nota 3)
ID      : [a-z][a-z0-9]* ;

WS      : [ \t\r\n]+  -> skip ;
COMMENT : '#' ~[\r\n]* -> skip ;
