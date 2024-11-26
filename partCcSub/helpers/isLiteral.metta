 ;; identifies literals like A B (NOT A)
 ;; ignores AND, OR, (OR ..), (AND ..)
(= (isLiteral $atom)
    (if (or (== $atom AND) (== $atom OR))
        False
        (if (== (get-metatype $atom) Symbol)
            True
            (let $head (car-atom $atom)
                (if (== $head NOT)
                    True
                    False
                )
            )
        )  
    )
)