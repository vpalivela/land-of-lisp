;; Loads
(load "../lisp-unit/lisp-unit.lisp")
(use-package :lisp-unit)

;; Purpose: to hold the descriptions of the locations that exist in the game
(defparameter *nodes* '((living-room (you are in the living-room.
				      a wizard is snoring loudly on the couch.))
			(garden (you are in a beautiful garden.
				 there is a well in fron of you.))
			(attic (you are in the attic.
				there is a giant welding torch in the corner.))))

;; Purpose: command to describe a location
(defun describe-location (location nodes)
  (cadr (assoc location nodes)))

(define-test describe-location
    (assert-equal '(you are in the living-room. a wizard is snoring loudly on the couch.) 
		  (describe-location 'living-room *nodes*)))

(run-tests)
