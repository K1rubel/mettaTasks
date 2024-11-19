; non-deterministic append
; appends $atom at the end of $expr
;! (register-module! ../helpers)

;! (import! &self helpers:isLiteral)

(= (append $atom $expr)
    (if (isLiteral $atom)
        (collapse 
            (let $U (union (superpose ($atom)) (superpose $expr)) $U)
        )
        (collapse 
            (let $U (union (superpose $atom) (superpose $expr)) $U)
        )
    )
)

! (append a (b c))