(= (expressionEquality $a $b)
    (let $diff (collapse (subtraction (superpose $a) (superpose $b)))
        (if (== $diff ())
            True
            False
        )))