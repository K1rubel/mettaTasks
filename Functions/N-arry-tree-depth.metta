
(= (map $f ()) ()) ; to find child's depth on every level
(= (map $f (:: $x $xs))
    (:: ($f $x) (map $f $xs))
)
 ; (Tree A (Cons (Tree B (Cons (Tree F ()) (Cons (Tree G (Cons (Tree H ()) ())) ()))) (Cons (Tree C ()) (Cons (Tree D ()) (Cons (Tree E ()) ())))))
 (: () List)
 (: :: (-> Number List List))

(: max_val (-> List Number))

(= (max_val (:: $x $xs)) ; find max values from within list of numbers
    (if (== $xs ())
        $x
        (max ($x (max_val $xs)))
    )
)
(: max (-> (Number Number) Number))
(= (max ($x $y)) ; simple comparison function
    (if (> $x $y)
        $x
        $y
    )
)
(: () tree)
(: tree ($t tree))

(= (depth (tree $x $xs)) ; main depth function calling all the above functions

    (if (== $xs ())
        1
        (+ 1 (max_val (map depth $xs)))
    )
)

! (depth (tree A (:: (tree B (:: (tree D ()) (:: (tree E ()) ()))) (:: (tree C ()) ()))))
! (depth (tree A (:: (tree B (:: (tree D ()) (:: (tree E (:: (tree F ()) ())) ()))) (:: (tree C ()) ()))))

;(:: 1 (:: 2 (:: 3 (:: 4 ()))))
