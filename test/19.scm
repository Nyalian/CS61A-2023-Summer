; Call expressions

(+ 1 2 3 4)
(+)
(*)
(- 12)
(- 20 1 2 3 4 5)
(+ (* 2 (+ 3 (* 2 2 2 2 3 3 7))) 1)
(number? 12)
(integer? 3.3)
(zero? 2)

; Definitions

(define (square x) (* x x))

(define (average x y) (/ (+ x y) 2))

(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (sqrt x)
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (= (square guess) x)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1))

; Let example

(define (star n m) 
  (let ((a (/ (* 360 m) n)))
    (define (side k) 
      (if (< k n) (begin (fd 100) (rt a) (side (+ k 1))))) 
    (side 0)))

(star 17 7)

; Sierpinski's Triangle (aka Sierpinski's Gasket).

(define (repeat k fn)
  ; Repeat fn k times.
  (fn)
  (if (> k 1) (repeat (- k 1) fn)))
(define (tri fn)
  ; Repeat fn 3 times, each followed by a 120 degree turn.
  (repeat 3 (lambda () (fn) (lt 120))))
(define (sier d k)
  ; Draw three legs of Sierpinski's triangle to depth k.
  (tri (lambda ()
         (if (= k 1) (fd d) (leg d k)))))
(define (leg d k)
  ; Draw one leg of Sierpinski's triangle to depth k.
  (sier (/ d 2) (- k 1))
  (penup) (fd d) (pendown))

(speed 0)
(rt 90)
(sier 200 5)

; List demos

(define s (cons 1 (cons 2 nil)))
(cons 3 s)
(cons 4 (cons 3 s))
(cons (cons 4 (cons 3 nil)) s)
(car (car (cons (cons 4 (cons 3 nil)) s)))
(cons s (cons s nil))

(list? s)
(list? nil)
(list? 4)
(null? nil)
(null? s)

(list 1 2)
(list 1 2 3 4)
(cdr (list 1 2 3 4))
(cons 0 (cdr (list 1 2 3 4)))

(list s)
(list 3 s)
(cons 3 s)
(list s s)
(cons s s)

(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(define squares (list 1 4 9 16 25))

(length squares)

(append s s)
(cons s s)

; Quotation demos

'(1 2 3)
(quote (1 2 3))
'(1 (2 3) 4)
(car (cdr (car (cdr '(1 (2 3) 4)))))
(car (cdr (car (cdr '(a (b c) d)))))
'(+ 1 2)
(car (quote (+ 1 2)))
(car '(+ 1 2))
(cons '+ (list 1 2))

; List processing

(define s (cons 1 (cons 2 nil)))
(append s s)
(map (lambda (x) (* 2 x)) '(3 4 5))
(map (lambda (s) (cons 2 s)) '((3) (4 5)))
(filter even? '(3 4 5))
(apply + '(3 4 5))
(map + '(3 4 5))

;;; non-empty subsets of integer list s that have an even sum
(define (even-subsets s)
  (if (null? s) nil
      (append (even-subsets (cdr s))
              (map (lambda (t) (cons (car s) t))
  	           (if (even? (car s))
		       (even-subsets (cdr s))
		       (odd-subsets (cdr s))))
	      (if (even? (car s)) (list (list (car s))) nil))))

;;; non-empty subsets of integer list s that have an odd sum
(define (odd-subsets s)
  (if (null? s) nil
      (append (odd-subsets (cdr s))
              (map (lambda (t) (cons (car s) t))
  	           (if (odd? (car s))
		       (even-subsets (cdr s))
		       (odd-subsets (cdr s))))
	      (if (odd? (car s)) (list (list (car s))) nil))))

;;; non-empty subsets of s
(define (nonempty-subsets s)
  (if (null? s) nil
      (let ((rest (nonempty-subsets (cdr s))))
	 (append rest
		 (map (lambda (t) (cons (car s) t)) rest)
		 (list (list (car s)))))))

(define (even-subsets2 s)
  (filter (lambda (s) (even? (apply + s))) (nonempty-subsets s)))