;; done
(module sim-lane-utils racket
    (provide all-cust-wait_lst
        most-crowded
        )

    (require "sim-lane.rkt")

    ;; return list of list of customers waiting in each lane
    (define (all-cust-wait_lst sim-lanes)
        (map (lambda (lane) (lane-queue lane)) sim-lanes)
        )

    (define (most-crowded sim-lanes)
    ; Helper function to sort the lanes (if customer id is null or length of the queue)
      (define (lane-crowded lane1 lane2) 
        (if (null? (lane-user lane1))
            #f
            (if (null? (lane-user lane2))
                #t
                (if (<= (length (lane-queue lane1)) (length (lane-queue lane2)))
                    #f
                    #t
                    )
                )
              )
            )

      ; Sort the lanes
      (define sorted-lanes (sort sim-lanes lane-crowded))
      (car sorted-lanes)
    )
)