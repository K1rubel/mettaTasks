;; retun only unique elements
;; works as follows
;; takes the head and updates the contents of the accumulator $acc
;; removes all occurrences of the $head from $tail using non-determinism and conditionals
;; calls the function again with the new accumulator now ($head) and the new tail with all the head instances removed from it
;; terminates when (cdr-atom $tailWithoutHead) == ()

(= (unyque $acc $expr)
    (if (== $expr ())
        $acc
        (let* (
            ($head (car-atom $expr))
            ($tail (cdr-atom $expr))
            ;($carry (cons-atom $head $acc))
            ($carry (collapse (union (superpose $acc) $head)))
            )
            (if (== $tail ())
                $carry
                (let $tailWithoutHead (collapse 
                        (let $x (superpose $tail)
                                (if (== $head $x)
                                    (superpose ())
                                    $x
                                )
            ))
                (unyque $carry $tailWithoutHead)
            )))))

(= (unikue $expr)
    (unyque () $expr)
)
;; test cases

! (unikue (A B A B C A)) ; (A B C)
! (unikue (A B A C A)) ; (A B C)
! (unikue (A A (NOT B) B A C A)) ; (A (NOT B) B C)
! (unikue (A D C A (NOT B) B A C A)) ; (A D C (NOT B) B)
