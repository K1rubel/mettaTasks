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
                )))))
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
                )))))
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
                    ))))))))

;; the function below assumes a terminal AND has already been found and the guardset of this node is given as an input
;; It finds the common elements between inverted COM set and the guardset of the POA and removes those elements from the POA's children list
        
(= (partCcSub $comSet $poa $subExpr)
    (let* 
        (
            ($poaGuardSet (getGuardSet $poa))
            ($invertedCom (invertLiterals $comSet))
            ($commonElements (collapse (intersection (superpose $poaGuardSet) (superpose $invertedCom))))
        )
        (updatePoa $commonElements $poa $subExpr)))

;; a function to check equality of two expressions
;; needed to make sure child ordering doesn't affect equality

(= (expressionEquality $a $b)
    (let $diff (collapse (subtraction (superpose $a) (superpose $b)))
        (if (== $diff ())
            True
            False
        )))

;; once called updatePoa finds the poa and updates the children list (remove the common element(s))

(= (updatePoa $common $poa $expr)
    (collapse (let $el (superpose $expr)
        (if (expressionEquality $el $poa)
            (collapse (subtraction (superpose $poa) (superpose $common)))
            (if (or (== (get-metatype $el) Symbol) (isLiteral $el))
                $el
                (if (== (getChildren $el) ())
                    $el
                    (updatePoa $common $poa $el)
                ))))))

;; tests for original oneCcSub function
;!(oneCcSub (AND B C) (AND B (AND B C) (AND (NOT B) D))) ; (AND B (AND C) (AND (NOT B) D))
;!(oneCcSub (AND B C) (AND B (OR (AND D) (AND B C)) (AND (NOT B) D))) ; (AND B (OR (AND D) (AND C)) (AND (NOT B) D))
;!(oneCcSub (AND B C) (AND (AND B (OR (AND D) (AND B C))) (AND (NOT B) D))) ; (AND (AND B (OR (AND D) (AND C))) (AND (NOT B) D))

;; this is the one on the Holman Book

;! (oneCcSub (AND B C) (AND A (OR (AND (NOT B)) (AND B (OR (AND D) (AND B C)))))) ; (AND A (OR (AND (NOT B)) (AND B (OR (AND D) (AND C)))))

;; tests for the new partCcSub function

;! (partCcSub (A B (NOT C)) (AND C D) (OR (AND (OR (AND A B))(AND C D)))) ; (OR (AND (OR (AND A B)) (AND D)))
;! (partCcSub ((NOT B) C) (AND B C) (AND B (OR (AND D) (AND B C)))) ;(AND B (OR (AND D) (AND C)))
;! (partCcSub ((NOT B) C) (AND B C) (OR (AND D) (AND B C))) ;(OR (AND D) (AND C))
