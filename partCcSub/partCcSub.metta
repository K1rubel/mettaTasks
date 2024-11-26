! (register-module! ./helpers)
! (import! &self helpers:isLiteral)
! (import! &self helpers:expressionEquality)
! (import! &self helpers:getGuardSet)
! (import! &self helpers:invertLiterals)
! (import! &self helpers:getLiterals)

;; the function below assumes a terminal AND has already been found and the guardset of this node is given as an input
;; And that the top most node is the immediate parent of the POA
;; It finds the common elements between inverted COM set and the guardset of the POA and removes those elements from the POA's children list
        
(= (partCcSub $comSet $poa $subExpr)
    (let* 
        (
            ($poaGuardSet (getGuardSet $poa))
            ($invertedCom (invertLiterals $comSet))
            ($commonElements (collapse (intersection (superpose $poaGuardSet) (superpose $invertedCom))))
        )
         (collapse (let $el (superpose $subExpr)
            (if (expressionEquality $el $poa)
                (collapse (subtraction (superpose $poa) (superpose $commonElements)))
                $el)))))

;; a function to check equality of two expressions
;; needed to make sure child ordering doesn't affect equality


;! (expressionEquality (AND A B) (AND B A)) ; True
! (partCcSub ((NOT B) C) (AND B C) (OR (AND D) (AND B C))) ;(OR (AND D) (AND C))