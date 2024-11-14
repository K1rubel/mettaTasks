;returns the length of an expression
(= (size-atom $expr)
    (if (== $expr ())
        0
        (+ 1 (size-atom (cdr-atom $expr)))
    )
)

! (size-atom (a b c (2 3)))
