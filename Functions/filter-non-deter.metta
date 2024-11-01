(: filter (-> (-> $t Bool) Expression Expression))
(= (filter $func $expr)
    (collapse ; Just to maintain the order of the elements
        (let $result (
            let $non-det (superpose $expr)
                (if (== (get-metatype $non-det) Expression)
                    (empty); I didn't think keeping expressions that may even contain an even number is appropriate
                    (case 
                        (isEven $non-det)
                        ((True $non-det))
                    )
                )
                    )
            $result
        )
    )
)


(=(isEven $x)
    (if (== (% $x 2) 0)
        True
        False
    )
)

! (filter isEven (2 3 4 5))
! (filter isEven (2 3 4 5 (8 9) 12 13 16))

; I do