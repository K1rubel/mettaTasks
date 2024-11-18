! (register-module! ./helpers)
! (import! &self helpers:map)
! (import! &self helpers:size-atom)
! (import! &self helpers:check-ex)
! (import! &self helpers:isLiteral)


(= (orCut $expr)
    (if (isLiteral $expr)
        $expr
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
                    (let 
                        $child (validateExpr $tail)
                        
                        (if (== (size-atom $child) 1)
                            ; add to the parent the guard sets of OR's child which in this case is just the literal itself
                            $child
                            (cdr-atom $child)
                        )
                    )
                    ;apply orCut to innner expressions
                    (let $reducted (map orCut $tail)
                        (cons-atom $head $reducted)
                    )
                )
            )
            (if (== (size-atom $tail) 1)
                (let* (
                    ($properTail (validateExpr $tail))
                    ($inner (orCut $properTail))
                    )
                    (cons-atom $head $inner)
                )
                ;check for OR nodes in the rest of the expression
                (let $inner-expr (map orCut $tail)
                    (cons-atom $head $inner-expr)
                )
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
! (orCut (AND B (OR (AND A (OR B)) (AND B (OR A)))))