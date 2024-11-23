(= (cleanExpr $expr)
    (if (== (cdr-atom $expr) ())
        (car-atom $expr)
        $expr
    )
)