! (register-module! ./helpers)
! (import! &self helpers:isMember)
! (import! &self helpers:getChildren)
;! (import! &self helpers:filterChildren)
! (import! &self helpers:getGuardSet)
! (import! &self helpers:getLiterals)
! (import! &self helpers:filter)
;! (import! &self helpers:isLiteral)
! (import! &self helpers:invertLiterals)
! (import! &self helpers:cleanExpr)

;; The Idea I got from the following code is what started it off
;; how to access deeper and deeper

(= (deeperAndDeeper $expr)
    (collapse (let $el (superpose $expr)
            (if (and (== (get-metatype $el) Symbol) (not (== $el D)))
                $el
                (if (== $el D)
                    (superpose ())
                    (deeperAndDeeper $el)
                )
            )
        
        )
    )
)
;; finds D and deletes it no matter where it is
;! (deeperAndDeeper (AND B (AND (NOT B) (NOT C) D)))


;; Assumes a single elligible terminal AND node in the current level
;; Returns an expression containing (False) or (True $commonElement) for later use

(= (checkForTerminalAnd $poaGuard $expr)
    (if (== $expr ())
        (False)
        (let* (
            ($head (car-atom $expr))
            ($tail (cdr-atom $expr))
            )
            (if (isLiteral $head)
                (checkForTerminalAnd $poaGuard $tail)
                (if (and (== (car-atom $head) AND) (== (getChildren $head) ()))
                    (let* (
                        ($terminalGuardSet (invertLiterals (getGuardSet $head)))
                        ($commonElements (collapse (intersection (superpose $poaGuard) (superpose $terminalGuardSet))))
                        )
                        (if (== $commonElements ())
                            (checkForTerminalAnd $poaGuard $tail)
                            (True (cleanExpr $commonElements))
                        )
                    )
                    (checkForTerminalAnd $poaGuard $tail)
                )
            )
        )
    )
)
;; the main constraint complement subtraction function
;; two parameteres - the point of application and the whole expression

(= (oneCcSub $poa $expr)
    (if (== $expr ())
        $expr
        (let* (
            ($poaGuardSet (getLiterals $poa))
            ($truthAndEl (checkForTerminalAnd $poa $expr))
            ($truthValue (car-atom $truthAndEl))
        )
        (if $truthValue
            (let $commonElements (cdr-atom $truthAndEl)
                (updatePoa $commonElements $poa $expr)
                ;$commonElements
            )
            (collapse (let $x (superpose $expr)
                (if (== (get-metatype $x) Symbol)
                    $x
                    (if (== (getChildren $x) ())
                        $x
                        (oneCcSub $poa $x)
                    )
                )
                )
            )
        )
    ))
)
;; once called this makes sure that the poa is updated as long as there is a poa in the expression irrespective of tree depth
(= (updatePoa $common $poa $expr)
    (collapse (let $el (superpose $expr)
        (if (== $el $poa)
            (collapse (subtraction (superpose $poa) (superpose $common)))
            (if (== (get-metatype $el) Symbol)
                $el
                (if (== (getChildren $el) ())
                    $el
                    (updatePoa $common $poa $el)
                )
                
            )
        )
    )
    )
)
;!(oneCcSub (AND B C) (AND B (AND B C) (AND (NOT B) D))) ; (AND B (AND C) (AND (NOT B) D))
;!(oneCcSub (AND B C) (AND B (OR (AND D) (AND B C)) (AND (NOT B) D))) ; (AND B (OR (AND D) (AND C)) (AND (NOT B) D))
;!(oneCcSub (AND B C) (AND (AND B (OR (AND D) (AND B C))) (AND (NOT B) D))) ; (AND (AND B (OR (AND D) (AND C))) (AND (NOT B) D))

;; this is the one on the Holman Book

! (oneCcSub (AND B C) (AND A (OR (AND (NOT B)) (AND B (OR (AND D) (AND B C)))))) ; (AND A (OR (AND (NOT B)) (AND B (OR (AND D) (AND C)))))
