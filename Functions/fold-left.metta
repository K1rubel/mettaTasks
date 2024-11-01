(:foldleft (-> (->$t $t) Grounded Expression Expression))
(= (foldleft $func $acc $expr)
    (if (== $expr ())
        $acc
        (let*(
                ($head (car-atom $expr))
                ($tail (cdr-atom $expr))
                ($carry ($func ($acc $head)))
            )
            (if (== (get-metatype $head) Expression)
                (if (== $tail ())
                    $acc
                    (foldleft $func $acc $tail)
                )
                (foldleft $func $carry $tail)
            )
            
        )
    )
)

(= (add ($x $y))
    (+ $x $y)
)

! (foldleft add 3 (1 2)); [3]
! (foldleft add 3 (1 2 3)); [9]
! (foldleft add 0 ((1 2))) ; [3]
! (foldleft add 3 ((1 2) 1)) ; [7]

! (foldleft add 0 (1 2 (3 4))); [10]
! (foldleft add 0 (1 2 (3 4) (2 3) 4)); [10]