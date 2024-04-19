;; Done
(module sim-event-queue racket
  (provide
   sim-add-event
   )

  (require "sim-event.rkt")

  ;; This is a sort of "priority queue"
  ;; in O(nlog(n))
  (define (sim-add-event sim-event-queue ev )
      (define (event-less? e1 e2)
        (or (< (event-time e1) (event-time e2))
            (and (= (event-time e1) (event-time e2))
                (< (event-user e1) (event-user e2)))))

      (define (insert-event event events)
        (cond
          [(null? events) (list event)]
          [(event-less? event (car events)) (cons event events)]
          [else (cons (car events) (insert-event event (cdr events)))]))

      (insert-event ev (sort sim-event-queue event-less?))
    )
  )
  