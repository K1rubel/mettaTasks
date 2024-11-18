
(= (validateExpr $expr)
    (let $head (car-atom $expr)
        (if (isLiteral $head)
            $expr
            (let $intermediate (car-atom $expr)
                $intermediate
            )
        )
    )
)
! (validateExpr ((a b)))

! (isLiteral A)