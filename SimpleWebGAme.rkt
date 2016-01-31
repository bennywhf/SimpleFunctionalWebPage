#lang racket
(require web-server/servlet)


(define (** a b) ; ** a:string, b:int => a * b
  (if (equal? 0 b)
      ""
      (string-append a (** a (- b 1)))
      )
  )

(define (start request) ;starting webserver.
  (show-counter 0 request))
 

(define (show-counter n request); produces webpage content.
  (local [(define (response-generator embed/url); makes linking to other functions possible.
            (define (place s)
  (string-append (** "<br>"  (random 45)) (** " " (random 100)) "<a href = " (embed/url next-number-handler) ">" s "</a>")
  )
            
            ;write response here!
(response/full
 301 #"Moved Permanently"
 (current-seconds) TEXT/HTML-MIME-TYPE
 (list (make-header #"Nil"
                    #"Nil"))
 (list (string->bytes/locale (string-append "<html><head><Title>Click Me!</Title> <meta http-equiv=\"refresh\" content=\"1;url=" 
                                            (embed/url update) "\" /> </head><body><center><H1>Clicked " (number->string n) " Time(s)<h1></center> <pre>" (place "!") "</pre></body></html>") )
))
            ;response ends here!
            )
 
(define (next-number-handler request)
    (show-counter (+ 1 n) request))

(define (update request)
  (show-counter n request))


]


    
    (send/suspend/dispatch response-generator)
    
    ))

(require web-server/servlet-env)
(serve/servlet start
               #:launch-browser? #t
               #:quit? #f
               #:listen-ip #f
               #:port 8000
               ;#:extra-files-paths
               ;(list (build-path "/home/benny/Desktop/RacketPage" "htdocs"))
               #:servlet-path
               "/home/benny/Desktop/RacketPage/racketpage.rkt")