; in an expression like this (AND A B (OR ...)) the OR will be the last element 
; or is this assumption wrong?
; get the last index atom and get the children and replace it with its own child

! (register-module! ./helpers)

! (import! &self helpers:index-atom)
! (import! &self helpers:size-atom)

(= (replace-OR $expr)
    (let* (
        ($index (- (size-atom $expr) 1))
        ($oRex (index-atom $expr $index))
        )
        (let* (
                ($oRchild (cdr-atom $oRex))
                ($num (size-atom $oRchild))
            )
            (if (== $num 1)
                (let 
                    $diff (collapse 
                        (let $super (superpose $expr)
                        ; find the difference -- this removes the OR expression
                        (subtraction $super (superpose ($oRex)))
                        ))
                        ; union of the OR-less orginal expression and OR-children
                        (collapse (union (superpose $diff) (superpose $oRchild)))
                )
                $expr
            )
        )
    )
)

! (replace-OR (OR a b c (OR d f)))
! (replace-OR (AND a b c (OR d f)))
! (replace-OR (AND a b c (OR d f)))
! (replace-OR (AND a b c (OR d)))
! (replace-OR (AND a (OR B)))
