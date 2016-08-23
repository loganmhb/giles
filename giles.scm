(define output-file (open-file "scheme_entry.s" "w"))

(define (emit . format-args)
  (define (format-string . args)
    (apply simple-format (cons #f args)))
  (let ((output (apply format-string format-args)))
    (display output)
    (display output output-file)))

(define (compile-program x)
  (define fixnum-shift 2)
  (define (immediate-rep x)
    (cond
     ;; Fixnums are encoded with tag b00
     ((integer? x) (ash x fixnum-shift))
     ((eq? #f x) #b00101111)
     ((eq? #t x) #b01101111)
     ((null? x) #b00111111)
     ;; #b1111 is the tag value for immediate types besides fixnums
     ((char? x) (+ #b1111 (ash (char->integer x) 8)))))
  (emit "\t.text\n")
  (emit "\t.globl scheme_entry\n")
  (emit "scheme_entry:\n")
  (emit "\tmovl $~a, %eax\n" (immediate-rep x))
  (emit "\tret\n"))

(with-output-to-port output-file
  (lambda ()
    (compile-program #\A)
    (force-output)
    (close-port output-file)))
