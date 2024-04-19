;; done
(module sim-lane-list racket
  (provide lane-list?
           less-crowded
           )

  (require "sim-lane.rkt")

  
  
  (define (lane-list? lst)
    (if (null? lst)
        #t
        (if (lane? (car lst))
            (lane-list? (cdr lst))
            #f
            )
        )
  )
    
    
  ;; This is a sort of "priority queue"
  ;; in O(nlog(n))
  (define (less-crowded sim-lanes )
      ; Helper function to sort the lanes (if customer id is null or length of the queue)
      (define (lane-less lane1 lane2) 
        (if (null? (lane-user lane1))
            #t
            (if (null? (lane-user lane2))
                #f
                (if (<= (length (lane-queue lane1)) (length (lane-queue lane2)))
                    #t
                    #f
                    )
                )
              )
            )

      ; Sort the lanes
      (define sorted-lanes (sort sim-lanes lane-less))
      (car sorted-lanes)
      )
  )