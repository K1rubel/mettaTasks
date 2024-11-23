(= (filterLiterals $exp)
    (if (== (get-metatype $exp) Symbol)
        (if (or (== $exp AND) (== $exp OR)) (empty) $exp)
        (if (== (car-atom $exp) NOT)
            $exp
            (empty)
        )
    )
)