! (register-module! ./helpers)
! (import! &self helpers:map)
! (import! &self helpers:size-atom)


(= (orCut $expr)
    ; check for an OR in the expression
    (let* (
        ($head (car-atom $expr))
        ($tail (cdr-atom $expr))
        )
        (if (== $head OR)
            ; check number of children of this OR
            (let $num (size-atom $tail)
                ; check if $num is 1 (only one child)
                (if (== $num 1)
                    ; replace the OR with its childs guardset
                    ; the child could be a literal or another tree
                    ; get the child and see which one it is
                    (let* (
                        ($child (car-atom $tail))
                        ($t (get-metatype $child))
                        )
                        (if (== $t Symbol)
                            ; add to the parent the guard sets of OR's child which in this case is just the literal itself
                            $tail
                            ;if $child is an expression
                            (let $boolFunc (car-atom $child)
                                ;check if the $child is a literal with NOT or AND/OR
                                ; if it is NOT just use this in place of the expression
                                (if (== $boolFunc NOT)
                                    $child
                                    ; if anything else append subsequent children of the child node to the parent expression
                                    (cdr-atom $child)
                                )
                            )

                        )
                    )
                    ;no reduction
                    $expr
                )
            )
            (if (== (size-atom $tail) 1)
                $expr
                ;check for OR nodes in the rest of the expression
                (let $inner-expr (map orCut $tail)
                    (cons-atom $head $inner-expr)
                )
            )
        )
    )
)


! (orCut (OR B)); (B)
! (orCut (OR (NOT B))); (NOT B)
! (orCut (OR (NOT B) D)); (OR (NOT B) D) "No reduction"
! (orCut (OR (AND B C (AND C F)))); (B C (AND C F)) "grand child of the POA"
! (orCut (AND (OR (NOT A)))); (AND (NOT A))
! (orCut (AND (OR (NOT A)) (AND A))); (AND (NOT A) (AND A))
