#lang br
(require racket/file)
(require "parser.rkt" "tokenizer.rkt" brag/support)

; PRE: a string for a filename or directory
; POST: Displays "Accepted" on successful parse, otherwise prints an error with its details
(define (parse filename)
  (define input-file (file->string filename))
  (if (list? (parse-to-datum (apply-tokenizer make-tokenizer input-file)))
    (display "Accepted")
    (display "Errored")
    )
  )
