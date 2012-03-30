;; Loads
(load "../lisp-unit/lisp-unit.lisp")
(use-package :lisp-unit)

(defparameter *board* 
    '(
        (1 ((1 4) (2 4) (3 4) (4 4) (5 4) (6 4) (7 0)))
        (2 ((1 4) (2 4) (3 4) (4 4) (5 4) (6 4) (7 0)))
    )
)

(defparameter *well-1* 0)
(defparameter *well-2* 1)
(defparameter *well-3* 2)
(defparameter *well-4* 3)
(defparameter *well-5* 4)
(defparameter *well-6* 5)
(defparameter *goal-well* 6)

(defun start-game () 
    (dotimes (player 2)
        (dotimes (well 6)
            (set-well player well 4)
        )
        ;; set goal well to zero
        (set-well player *goal-well* 0)
    )
)

(defun print-board ()
    (print '----------------------CURRENT-BOARD-----------------------------)
    (dotimes (player 2)
        (format t "~&Player ~D |~T~D |~T~D |~T~D |~T~D |~T~D |~T~D |~T~D"
                (+ player 1) 
                (seeds-in-well player *well-1*) (seeds-in-well player *well-2*) (seeds-in-well player *well-3*)
                (seeds-in-well player *well-4*) (seeds-in-well player *well-5*) (seeds-in-well player *well-6*)
                (seeds-in-well player *goal-well*)
        )
    )
    (print '----------------------------------------------------------------)
)

(defun set-well (pIndex well value)
    (setf 
        (nth 1 (nth well (nth 1 (nth pIndex *board*))))
        value
    )
)

(defun increment-well (pIndex well value)
    (set-well pIndex well (+ (seeds-in-well pIndex well) value))
)

(defun decrement-well (pIndex well value)
    (set-well pIndex well (- (seeds-in-well pIndex well) value))
)

(defun value-of (index collection)
    (nth 1 (nth index collection))
)

(defun get-player (index)
    (value-of index *board*)
)


(defun seeds-in-well (pIndex well)
    (value-of well (get-player pIndex))
)

(defun next-player (pIndex)
    (cond
        ((eq pIndex 0) (+ pIndex 1))
        ((eq pIndex 1) (- pIndex 1))
    )
)

(defun sow-well (pIndex well)
    (dotimes (n (seeds-in-well pIndex well))
        (if (>= *goal-well* (+ well n 1))
            (increment-well pIndex (+ well n 1) 1)
            (increment-well (next-player pIndex) (- (+ well n ) *goal-well*) 1)
        )
    )
    (set-well pIndex well 0)
)



;; Tests:

(define-test spec-2.4-when-a-player-sows-a-well-then-the-opponents-wells-are-also-included-in-the-sowing-process
    (dotimes (player 2)
        (start-game)
        (sow-well player *well-5*)
        (assert-eq 5 (seeds-in-well (next-player player) *well-1*))
    )
)

(define-test spec-2.3-when-a-player-sows-a-well-then-the-players-goal-well-is-updated-in-the-sowing-process
    (dotimes (player 2)
        (start-game)
        (sow-well player *well-3*)
        (assert-eq 1 (seeds-in-well player *goal-well*))
    )
)

(define-test spec-2.2-when-a-player-sows-a-well-then-the-subsequent-wells-are-incremented-by-1
    (dotimes (player 2)
        (start-game)
        (sow-well player *well-2*)
        (assert-eq 5 (seeds-in-well player *well-3*))
        (assert-eq 5 (seeds-in-well player *well-4*))
        (assert-eq 5 (seeds-in-well player *well-5*))
        (assert-eq 5 (seeds-in-well player *well-6*))
    )
)

(define-test spec-2.1-when-a-player-sows-a-well-then-the-source-well-is-empty-after-sowing
    (dotimes (player 2)
        (start-game)
        (sow-well player *well-2*) 
        (assert-eq 0 (seeds-in-well player *well-2*))
    )
)

(define-test spec-1.2-when-starting-a-game-each-player-has-1-goal-well-with-0-seeds
    (dotimes (player 2)
        (start-game)
        (assert-eq 0 (seeds-in-well player *goal-well*))
     )
)

(define-test spec-1.1-when-starting-a-game-each-player-has-6-wells-with-4-seeds
    (dotimes (player 2)
        (start-game)
        (assert-eq 4 (seeds-in-well player *well-1*))
        (assert-eq 4 (seeds-in-well player *well-2*))
        (assert-eq 4 (seeds-in-well player *well-3*))
        (assert-eq 4 (seeds-in-well player *well-4*))
        (assert-eq 4 (seeds-in-well player *well-5*))
        (assert-eq 4 (seeds-in-well player *well-6*))
     )
)

(run-tests)
