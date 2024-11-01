(= (reverse $seed $expr)
    (if (== $expr ())
        $seed
        (let*(
            ($head (car-atom $expr))
            ($new-expr (cons-atom $head $seed))
            ($tail (cdr-atom $expr))
            )
            (reverse $new-expr $tail)
        )
    )
)

! (reverse () (A B C 1 2)); [(2 1 C B A)]