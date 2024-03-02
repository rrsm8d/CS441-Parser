#lang br
(require "lexer.rkt" brag/support)

(define (make-tokenizer ip [path #f])
  (port-count-lines! ip)
  (lexer-file-path path)
  (define (handle-lexer-error excn)
    (define excn-srclocs (exn:fail:read-srclocs excn))
    (srcloc-token (token 'ERROR) (car excn-srclocs)); Create an 'ERROR token to display to the user, passing in the line location as well.
    ) 
  (define (next-token)
    (with-handlers ([exn:fail:read? handle-lexer-error])(my-lexer ip)))
  next-token)

(provide make-tokenizer)