(= (depth ()) 0) ; depth of an empty branch 
                
(= (depth (node $top $left_ $right_)); recursive depth definition
        (let* (
            ($l_ (depth $left_))
            ($r_ (depth $right_))
        )
        (+ 1 (if (> $l_ $r_); left and right depth branch comparison
                $l_
                $r_
            )
        )
    )
        
)
                
    ! (depth (node 1 (node 2 (node 4 (node 5 () ()) ()) ()) (node 3 (node 6 (node 7 (node 8 (node 11 () ()) (node 9 () (node 10 () ()))) ()) ()) ()))); example run of the le (maximum depth function)
