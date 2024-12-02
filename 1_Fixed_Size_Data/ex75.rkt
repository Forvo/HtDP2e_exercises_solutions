; 75

; 未完成

(define-struct ufo [loc vel])
    ; A UFO is a structure: 
    ;   (make-ufo Posn Vel)
    ; interpretation (make-ufo p v) is at location
    ; p moving at velocity v

(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))

(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))
 
(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))

; UFO -> UFO
; determines where u moves in one clock tick; 
; leaves the velocity as is

(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2)
              (make-ufo (make-posn 17 77) v2))

(define (ufo-move-1 u) u)

; UFO -> UFO 
(define (ufo-move-1 u)
  (... (posn-x (ufo-loc u)) ...
   ... (posn-y (ufo-loc u)) ...
   ... (vel-deltax (ufo-vel u)) ...
   ... (vel-deltay (ufo-vel u)) ...))

; Posn Vel -> Posn 
; adds v to p 
(define (posn+ p v) p)

(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))

(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))

(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))

