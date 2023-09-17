(define (make-adder num) (lambda (inc) (+ inc num)))

(define (composed f g) (lambda (x) (f (g x))))

(define (my-filter pred s)
  (cond
    ((null? s) nil)
    ((pred (car s)) (cons (car s) (my-filter pred (cdr s))))
    (else (my-filter pred (cdr s)))
    ))

(define (exp b n)
  (define (helper b n so-far) 
    (if (= n 0)
      so-far
      (helper b (- n 1) (* so-far b))))
  (helper b n 1))

(define (interleave lst1 lst2)
  (define (helper lst1 lst2 turns)
    (cond
    ((null? lst1) lst2)
    ((null? lst2) lst1)
    ((= turns 0) (cons (car lst1) (helper (cdr lst1) lst2 1)))
    (else (cons (car lst2) (helper lst1 (cdr lst2) 0)))))
  (helper lst1 lst2 0))

(define (square n) (* n n))

(define (pow base exp)
  (cond
    ((= exp 0) 1)
    ((= exp 1) base)
    ((odd? exp) (* base (pow base (- exp 1))))
    (else (pow (square base) (/ exp 2)))
    ))
