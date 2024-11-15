(= (index-atom $expr $index)
    (let*
        (
            ($head (car-atom $expr))
            ($tail (cdr-atom $expr))
        )
        (if (< (- (size-atom $expr) 1) $index)
            -1
            (if (== $index 0)
                $head
                (index-atom $tail (- $index 1))
            )
        )
    )
)