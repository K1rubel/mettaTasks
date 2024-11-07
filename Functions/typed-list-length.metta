;for a list of numbers
    (: () List); empty container as a stop criteria

    (: List (-> Number List List)); defining type for list structure
                
    (: list_length (-> List Number)); defining type of length function
                
    (= (list_length ()) 0); the stop criteria
    (= (list_length (List $outer $inner)); recursive definition
        (+ 1 (list_length $inner)) 
    )
                
    !(list_length (List 1 (List 2 (List 3 (List 4 (List 5 (List 0 ())))))))