;!(register-module! ../helpers)
! (import! &self helpers:isLiteral)

(: filter (-> (-> $t Bool) Expression Expression))
(= (filter $func $expr)
    (collapse ; Just to maintain the order of the elements
        (let $result (
            let $non-det (superpose $expr)
                (case 
                    ($func $non-det)
                    ((True $non-det))
                )
                    )
            $result
        )
    )
)

;! (filter isLiteral (A B (OR B) (NOT B) (AND C)))



