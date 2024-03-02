#lang br
(require "lexer.rkt" brag/support rackunit)

(define (lex str)
  (apply-port-proc my-lexer str)
  )

; Random tests to check some of the regex matching


; EMPTY FILE
(check-equal? (lex "") empty)

; WHITESPACE
(check-equal?
 (lex " ")
 (list (srcloc-token (token " " #:skip? #t)
                     (srcloc 'string 1 0 1 1 )))
 )

; DIGIT
(check-equal?
 (lex "1")
 (list (srcloc-token (token 'A-DIGIT 1)
                     (srcloc 'string 1 0 1 1 )))
 )

; ID
(check-equal?
 (lex "identity123")
 (list (srcloc-token (token 'A-ID "identity123")
                     (srcloc 'string 1 0 1 11 )))
 )

; LABEL (colon should be its own token, will be remade into LABEL in the parser)
(check-equal?
 (lex "identity123:")
 (list (srcloc-token (token 'A-ID "identity123")
                     (srcloc 'string 1 0 1 11 ))
       (srcloc-token (token 'A-COLON ":")
                     (srcloc 'string 1 11 12 1)))
 )

; EOF
(check-equal?
 (lex "$$")
 (list (srcloc-token (token 'A-EOP "$$")
                     (srcloc 'string 1 0 1 2 )))
 )

; ERROR (This should fail, as it is not a label)
#|
(check-equal?
 (lex "$b29")
 (list (srcloc-token (token 'A-LABEL "$b29")
                     (srcloc 'string 1 0 1 4 )))
 )
|#