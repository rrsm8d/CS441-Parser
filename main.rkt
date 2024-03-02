#lang br
(require racket/file)
(require "parser.rkt" "tokenizer.rkt" brag/support)

(define (parse filename)
  (define input-file (file->string filename))
  (if (list? (parse-to-datum (apply-tokenizer make-tokenizer input-file)))
    (display "Accepted")
    (display "Errored")
    )
  )
