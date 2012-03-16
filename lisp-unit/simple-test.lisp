;; this is a simple test to test whether lisp-unit is loaded properly

(load "lisp-unit.lisp")
;;(use-package :lisp-unit)

(defun my-sqr (x) (* x x))

(define-test my-sqr 
   (assert-equal 4 (my-sqr 2)))

