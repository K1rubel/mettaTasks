(: filter (-> (-> $t Grounded) Expression Expression))
(= (filter $func $expression)
    (if (== $expression ())
        ()
        (let* (
            ($head (car-atom $expression))
            ($tail (cdr-atom $expression))
            ($x (filter $func $tail))
            )
            (if (== (get-metatype $head) Expression)
                    (if (== $tail ())
                        $head
                        (cons-atom $head $x)
                    ) 
            (if (== ($func $head) True)
                (cons-atom $head $x)
                (filter $func $tail)
            )
            )
        )
    )
)


(= (isEven $x)
    (if (== (% $x 2) 0)
        True
        False
    )
)

! (filter isEven (2 3 4 7 8 10 2)); [(2 4 8 10 2)]
! (filter isEven (2 3 4 7 (8 10 5) 2)); [(2 4 (8 10 5) 2)]
! (filter isEven ((1 2 4) 3)); [((1 2 4))]
