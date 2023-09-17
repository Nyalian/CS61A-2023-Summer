(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (helper counts old)
          (if (null? old)
              nil
              (cons (cons counts (cons (car old) nil)) 
                    (helper (+ counts 1) (cdr old)))))
  (helper 0 s))
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists S1 and S2 according to ORDERED? and return
;; the merged lists.
(define (merge ordered? s1 s2)
  ; BEGIN PROBLEM 16
  (cond 
    ((null? s1) s2)
    ((null? s2) s1)
    ((ordered? (car s1) (car s2)) (cons (car s1) (merge ordered? (cdr s1) s2)))
    (else (cons (car s2) (merge ordered? s1 (cdr s2)))))
  )
  ; END PROBLEM 16

;; Optional Problem

;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN OPTIONAL PROBLEM
         expr
         ; END OPTIONAL PROBLEM
         )
        ((quoted? expr)
         ; BEGIN OPTIONAL PROBLEM
          expr
         ; END OPTIONAL PROBLEM
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM
           (cons form (cons params (map (lambda (x) (let-to-lambda x)) body)))
           ; END OPTIONAL PROBLEM
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM
           (cons (cons 'lambda (cons (car (zip values)) (map (lambda (x) (let-to-lambda x)) body))) (map (lambda (x) (let-to-lambda x)) (cadr (zip values))))
           ;(map (lambda (x) (let-to-lambda x)) (cadr (zip values)))
           ; END OPTIONAL PROBLEM
           ))
        (else
         ; BEGIN OPTIONAL PROBLEM
         (map (lambda (x) (let-to-lambda x)) expr)
         ; END OPTIONAL PROBLEM
         )))

; Some utility functions that you may find useful to implement for let-to-lambda

(define (zip pairs)
  (define first (map (lambda (x) (car x)) pairs))
  (define second (map (lambda (x) (cadr x)) pairs))
  (cons first (cons second nil)))
