(define (make-even t)
	(if (odd? (label t))
		(tree (+(label t) 1) (map (lambda (x) (make-even x)) (branches t)))
		(tree (label t) (map (lambda (x) (make-even x)) (branches t)))))

(define (find t x) 
	(if (= (label t) x)
		#t
		(< 0 (length (filter (lambda (tr) (find tr x)) (branches t))))))

(define (n-ary t n) 
	(cond ((is-leaf t) #t)
			((not (= n (length (branches t)))) #f)
			(else (= n (length (filter (lambda (tr) (n-ary tr n)) (branches t)))))))
