;; Loads
(load "../lisp-unit/lisp-unit.lisp")
(use-package :lisp-unit)

;; steal-emerald: list -> string
;; Purpose: 
;;   As part of being a high tech bandit, by nights
;;   I steal emeralds from moving bullet trains
;;   using my awesome wet suit that gives me 
;;   aerodynamic properties to cling to train and avoid hypothermia
(defun steal-emerald (x)
   (caddr x))

;; its-go-time: I must now steal the emerald located in the 3rd car between cameras and guards
(define-test its-go-time
   (assert-equal 'emerald (steal-emerald '(train-controls cameras emerald guards))))

(run-tests)
