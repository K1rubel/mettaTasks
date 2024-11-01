(: map (-> (->$t $t) Expression Expression))

(= (map $func $expr)
    (collapse ; Just to maintain the order of elements
        (let $result 
                (let $non-det (superpose $expr)
                    (if (== (get-metatype $non-det) Expression)
                        $non-det
                        ($func $non-det)
                    )
                )
        $result
    )
    )
)
(= (add2 $x)
    (+ $x 2)
)

! (map add2 (2 3 4)) ; [(4 5 6)]
! (map add2 (2 3 4 (2 3))); [4 5 6 (2 3)]
! (map add2 (2 3 4 (2 3) 5)); [(4 5 6 (2 3) 7)]