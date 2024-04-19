;; done
(module sim-event-utils racket
    (provide event-params-lst
        is-sorted
        )

    (require "sim-event.rkt")

    ;; return list of parameters of the events
    (define (event-params-lst sim-events)
        (map (lambda (event) (event-params event)) sim-events)
        )

    ;; return true if the list is sorted
    ;; compare time of the events (if they are in ascending order then the list is sorted)
    ;; if time is same then compare user-id (if they are in ascending order then the list is sorted)
    ;; https://docs.racket-lang.org/reference/pairs.html#%28part._.Additional_.List_.Functions_and_.Synonyms%29
    (define (is-sorted lst)
        (cond
            [(empty? lst) #t]
            [(empty? (rest lst)) #t]
            [(and (or (and (< (event-time (first lst)) (event-time (second lst)))
                    (and (= (event-time (first lst)) (event-time (second lst)))
                        (<= (event-user (first lst)) (event-user (second lst))))))
            (is-sorted (rest lst)))]
            [else #f]
        )
    )
)