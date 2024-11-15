(= (size-atom $expr)
    (if (== $expr ())
        0
        (+ 1 (size-atom (cdr-atom $expr)))
    )
)