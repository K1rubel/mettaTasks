;; inverts literals in an expression of literals
;; (A (NOT B) C) --> ((NOT A) B (NOT C))

(= (invertLiterals $guardSet)
    (collapse (let $a (superpose $guardSet)
            (unify $a (NOT $x)
                $x
                (NOT $a)
            )
        )
    )
)