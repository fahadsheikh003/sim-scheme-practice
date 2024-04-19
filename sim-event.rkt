(module event racket
  (provide event
           event?
           event-time
           event-type
           event-user
           event-lane
           event-params
           ENTER_EVENT
           CHECKOUT_EVENT
           LEAVE_EVENT
           event->string)

  (define ENTER_EVENT 1)
  (define CHECKOUT_EVENT 2)
  (define LEAVE_EVENT 3)

  (define event-dict
    (list (cons ENTER_EVENT "ENTER_EVENT")
          (cons CHECKOUT_EVENT "CHECKOUT_EVENT")
          (cons LEAVE_EVENT "LEAVE_EVENT")))

  ;; constructor.
  ;; ( time . ( id . (user . id-lane)))
  (define (event time id params)
    ; returns an event if the parameters are valid
    (if (event? (cons time (cons id params)))
        (cons time (cons id params))
        (raise 'event)))

  ;; P: True
  (define (event? val)
    (if (pair? val) ; val is a pair (first -> time, second -> (id . (user . id-lane))
      (if (pair? (cdr val)) ; second is a pair (first -> id, second -> (user . id-lane))
        (if (pair? (cdr (cdr val))) ; second is a pair (first -> user, second -> id-lane)
          (if (>= (event-time val) 0) ; time is a non-negative number
            (if (or (eq? (event-type val) ENTER_EVENT)
                    (eq? (event-type val) CHECKOUT_EVENT)
                    (eq? (event-type val) LEAVE_EVENT))
              #t
              #f)
            #f)
          #f)
        #f)
      #f))

  ;; P: valid event
  (define (event-time ev)
    (car ev))

  ;; P: valid event
  (define (event-type ev)
    (car (cdr ev)))

  ;; P: event-params
  (define (event-params ev)
    (cdr (cdr ev)))

  (define (event-user ev)
    (car (cdr (cdr ev))))

  (define (event-lane ev)
    (cdr (cdr (cdr ev))))

  (require racket/dict)
  (define (event->string ev)
    (format "~a" (dict-ref event-dict (event-type ev)))))
