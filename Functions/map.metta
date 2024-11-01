(: map (-> (-> $t $t) Expression Expression))
(= (map $func $ex) 
    (if (== $ex ())
        ()
        (let* 
            (
                ($head (car-atom $ex))
                ($tail (cdr-atom $ex))
                ($new-head ($func $head))
                ($new-tail (map $func $tail))
            )
            (if (== (get-metatype $head) Expression)
                    (if (== $tail ())
                        ($head)
                        (cons-atom $head $new-tail)
                    )
                (cons-atom $new-head $new-tail) 
            )
        )
    )
)
; add function
(= (add2 $x)
    (+ $x 2)
)

! (map not (True False True))
! (map not (True (False True)))
! (map not (True (False True) False))

! (map add2 (1 2 3)); [(3 4 5)]
! (map add2 (1 2 3 (5 6))); [(3 4 5 (7 8))]
! (map add2 (1 2 3 (2 3) 4)); [(3 4 5 (4 5) 6)]
! (map add2 ((1) 2 3)); [((3) 4 5)]
! (map add2 ((1 4) 2 3)); [((3 6) 4 5)]
! (map add2 ((1 4) 2 3 (2 3))); [((3 6) 4 5 (4 5))]


