(= (foldright $func $acc $expr)
    (if (== $expr ())
        $acc
        (let* (
            ($head (car-atom $expr))
            ($tail (cdr-atom $expr))
        )
            (if (== (get-metatype $head) Grounded)
                ($func $head (foldright $func $acc $tail))
                (foldright $func $acc $tail)
            )
            
        )
    )
)

(= (add $x $y)
    (+ $x $y)
)

! (foldright add 0 ()); [0]
! (foldright add 0 (1)); [1]
! (foldright add 2 (1)); [3]
! (foldright add 2 (1 2 3)); [8]
! (foldright add 2 (1 2 3 (2))); [8]
! (foldright add 2 (1 2 3 (2 4))); [8]
! (foldright add 2 (1 2 3 (2 4) (2))); [8]
! (foldright add 2 ((1 2 3) (2 4) (2))); [2]

