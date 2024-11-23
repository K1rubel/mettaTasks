! (import! &self helpers:filterChildren)

(= (getChildren $exp)
     (case $exp
       (
         (() $exp)
         ((NOT $x) ())
         ($else (if (== (get-metatype $exp) Expression) 
                (collapse (filterChildren (superpose $exp))) 
                ()
                )
        )
    )
)
)