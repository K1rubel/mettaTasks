;; test cases

! (oneCcSub ((NOT B) C) (AND B C) (OR (AND D) (AND B C))) ;(OR (AND D) (AND C))
! (oneCcSub ((NOT B) C) (AND B C) (AND (AND D C) (NOT B) A (AND B C))) ;; (AND (AND D C) (NOT B) A (AND C))
! (oneCcSub ((NOT B) C) (AND A C) (AND (AND D C) (NOT B) A (AND B C))) ;; (AND (AND D C) (NOT B) A (AND B C)) ;; no reduction because the POA is not in the expression
! (oneCcSub (A B C) (AND (NOT A) C) (OR (AND (NOT A) C) (OR A B (AND B C)))) ;; (OR (AND C) (OR A B (AND B C)))
! (oneCcSub ((NOT A) B C) (AND (NOT A) C) (OR (AND (NOT A) C) (OR A B (AND B C)))) ;; (OR (AND (NOT A) C) (OR A B (AND B C))) ;; no reduction - COM set doesn't contain negated terminals
