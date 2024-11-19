; metta 0.2.0
; finds an OR expression and applies the orCut transformation

! (register-module! ./helpers)

! (import! &self helpers:append)
! (import! &self helpers:isLiteral)

(= (reduceOR $acc $expr)
    (if (== $expr ())
        $acc
        (let* (
            ($head (car-atom $expr))
            ($tail (cdr-atom $expr))
            )
            (case (isLiteral $head)
                (
                    (False 
                        (unify (OR $x) $head 
                            (let $carry (append $x $acc)
                                    (reduceOR $carry $tail)
                            )
                            (let $carry (append ($head) $acc)
                                    (reduceOR $carry $tail)
                            )
                        )
                    )
                    (True
                        (let $carry (append $head $acc)
                            (reduceOR $carry $tail)
                        )
                    )
                )
            )
        )
    )  
)
; test cases
! (reduceOR () (AND A B)) ; (AND A B)
! (reduceOR () (AND (OR B))) ; (AND B) 
! (reduceOR () (AND (OR B A))) ; (AND (OR B A)) 
! (reduceOR () (AND A (NOT C) B)) ; (AND A (NOT C) B)
! (reduceOR () (AND A (NOT C) (OR B) B)) ; (AND A (NOT C) B B)
! (reduceOR () (AND A (NOT C) (OR B A) (OR B) B)) ; (AND A (NOT C) (OR B A) B B)
! (reduceOR () (AND A (NOT C) (OR B) (OR B A)  B)) ; (AND A (NOT C) B (OR B A) B)
! (reduceOR () (AND A (NOT C) (AND F) (OR B A) (OR B) B)) ; (AND A (NOT C) (AND F) (OR B A) B B)
