#lang br
(require brag/support)

(define-lex-abbrev digits
  (char-set "0123456789")
  )

; I don't know where I'm supposed to plug the regex anywhere in this lexer for checking 'A-ID
; After 10+ hours of experimenting and reading endless docs, im giving up and just hard coding it like this
(define-lex-abbrev letters
  (:+ (char-set "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))
  )

(define-lex-abbrev letters-and-digits
  (:+ (char-set "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"))
  )

; PRE: A string representing a file
; POST: tokenizes the string and returns it
(define my-lexer
  (lexer-srcloc
   ["\n" (token 'A-NEWLINE lexeme)]
   [whitespace (token lexeme #:skip? #t)] ; mark whitespace token as skippable
   ["(" (token 'A-LPAREN lexeme)]
   [")" (token 'A-RPAREN lexeme)]
   ["=" (token 'A-EQUALS lexeme)]
   [";" (token 'A-SEMICOLON lexeme)]
   [":" (token 'A-COLON lexeme)]
   ["+" (token 'A-PLUS lexeme)]
   ["-" (token 'A-MINUS lexeme)]
   ["*" (token 'A-MULT lexeme)]
   ["/" (token 'A-DIV lexeme)]
   ["<" (token 'A-LT lexeme)]
   [">" (token 'A-GT lexeme)]
   ["<=" (token 'A-LTE lexeme)]
   [">=" (token 'A-GTE lexeme)]
   ["<>" (token 'A-NOTEQUALS lexeme)]
   ["if" (token 'A-IF lexeme)]
   ["while" (token 'A-WHILE lexeme)]
   ["read" (token 'A-READ lexeme)]
   ["write" (token 'A-WRITE lexeme)]
   ["return" (token 'A-RETURN lexeme)]
   ["break" (token 'A-BREAK lexeme)]
   ["endwhile" (token 'A-ENDWHILE lexeme)]
   ["goto" (token 'A-GOTO lexeme)]
   ["gosub" (token 'A-GOSUB lexeme)]
   ["end" (token 'A-END lexeme)]
   ["true" (token 'A-TRUE lexeme)]
   ["false" (token 'A-FALSE lexeme)]
   [digits (token 'A-DIGIT (string->number lexeme))]
   [(:seq letters (:? letters-and-digits)) (token 'A-ID lexeme)] ; basically [a-zA-Z][a-zA-Z0-9]*
   ["$$" (token 'A-EOP lexeme)]
   )
  )

(provide my-lexer) ; Allows other rkt files to access this funct when required.