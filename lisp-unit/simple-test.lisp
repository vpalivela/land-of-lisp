;; this is a simple test to test whether lisp-unit is loaded properly
;;
;;
;; To run this, Open REPL and type the following in one line
;; (load "simple-test.lisp")(run-tests)

;; Load list-unit package
(load "lisp-unit.lisp")
(use-package :lisp-unit)


;; my-sqr: num -> num
;; Purpose: To compute a square of a number
;; Examples: (mysqr 2) => 4
(defun my-sqr (x) (* x x))

;; Tests:
(define-test my-sqr-test 
   (assert-equal 4 (my-sqr 2)))