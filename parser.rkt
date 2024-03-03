#lang brag 
A-PROGRAM : A-LINELIST A-EOP [A-NEWLINE]* ; Some input test files had a newline after $$
A-LINELIST : A-LINE [A-LINELIST]
A-LINE : [A-LABEL] A-STMT (A-LINETAIL)* A-NEWLINE
A-LABEL : (A-ID A-COLON)
A-LINETAIL : (A-SEMICOLON A-STMT)
A-STMT : (A-ID A-EQUALS A-EXPR)
     | (A-IF A-LPAREN A-BOOLEAN A-RPAREN A-STMT)
     | (A-WHILE A-LPAREN A-BOOLEAN A-RPAREN) A-NEWLINE [A-LINELIST] A-ENDWHILE ;
     | (A-READ A-ID)
     | (A-WRITE A-EXPR)
     | (A-GOTO A-ID)
     | (A-GOSUB A-ID)
     | A-RETURN
     | A-BREAK
     | A-END
A-BOOLEAN : A-TRUE
        | A-FALSE
        | (A-EXPR A-BOOL-OP A-EXPR)
A-BOOL-OP : A-LT
          | A-GT
          | A-GTE
          | A-LTE
          | A-NOTEQUALS
          | A-EQUALS
A-EXPR : (A-ID [A-ETAIL])
     | (A-NUM [A-ETAIL])
     | (A-LPAREN A-EXPR A-RPAREN)
A-ETAIL : (A-PLUS A-EXPR)
      | (A-MINUS A-EXPR)
      | (A-MULT A-EXPR)
      | (A-DIV A-EXPR)
A-NUM : [A-NUMSIGN] A-DIGIT+
A-NUMSIGN : A-PLUS
        | A-MINUS
        | ""
; NOTE: the A- prefix for tokens is to avoid namespace collisions. 