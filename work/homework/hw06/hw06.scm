(define (no-repeats lst)
  (define (helper new old)
    (cond ((null? old) nil)
          ((< 0 (length (filter (lambda (x) (= x (car old))) new))) (helper new (cdr old)))
          (else (cons (car old) (helper (cons (car old) new) (cdr old))))))
  (helper nil lst))

(define (student-attend-class student class)
  (student-create (student-get-name student) (cons class (student-get-classes student))))

(define (teacher-hold-class teacher)
  (teacher-create (teacher-get-name teacher) (teacher-get-class teacher) (map (lambda (x) (student-attend-class x (teacher-get-class teacher))) (teacher-get-students teacher)))
  )

(define (add-leaf t x)
  (if (is-leaf t)
      t
      (begin (define mapped-branches
                     (map (lambda (tr) (add-leaf tr x)) (branches t)))
             (tree (label t)
                   (append mapped-branches (list (tree x nil)))))))
