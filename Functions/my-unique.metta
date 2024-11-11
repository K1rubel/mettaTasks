
(= (my-unique $expr)
    (let $len (size-atom $expr)
        (if (< $len 2)
            (superpose $expr)
            (let* (
                ($head (car-atom $expr))
                ($tail (cdr-atom $expr))
                ($left-over (collapse (subtraction (superpose $tail) (superpose ($head)))))
                 )
                 (let $sub (collapse (my-unique $left-over))
                    (union (superpose ($head)) (superpose $sub))
                 )
            )
        )
    ) 
)
(= (size-atom $expr)
    (if (== $expr ())
        0
        (+ 1 (size-atom (cdr-atom $expr)))
    )
)

! (my-unique (A)); [A]
! (my-unique ()); []
! (my-unique (A B)); [B, A]
! (my-unique (A B C)); [C, B, A]
! (my-unique (A A)); [A]
! (my-unique (A B B)); [B, A]
! (my-unique (A B B C)); [C, B, A]
! (my-unique (A B B C C D)); [D, C, B, A]
! (my-unique (A B B C C C D)); [D, C, C, B, A]; I guess by recursively applying any output with reduandant term, we can get rid of all of them.