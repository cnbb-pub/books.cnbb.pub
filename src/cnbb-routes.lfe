(defmodule cnbb-routes
  (export all))

(include-lib "exemplar/include/html-macros.lfe")
(include-lib "lfest/include/macros.lfe")

(defroutes
  ('GET "/" (cnbb-content:home-page arg-data))
  ;; Books
  ('GET "/books" (cnbb-content:books arg-data))
  ('GET "/books/new-releases" (cnbb-content:books-new arg-data))
  ('GET "/books/popular" (cnbb-content:books-popular arg-data))
  ('GET "/books/all" (cnbb-content:books-all arg-data))
  ('GET "/books/upcoming" (cnbb-content:books-upcoming arg-data))
  ('GET "/books/buy" (cnbb-content:books-buy arg-data))
  ('GET "/books/:isbn" (cnbb-content:book isbn arg-data))
  ;; Genres
  ('GET "/genres" (cnbb-content:genres arg-data))
  ('GET "/genres/:id" (cnbb-content:genre id arg-data))
  ;; Authors
  ('GET "/authors" (cnbb-content:authors arg-data))
  ('GET "/authors/:id" (cnbb-content:author id arg-data))
  ;; Company
  ('GET "/about" (cnbb-content:about arg-data))
  ('GET "/media" (cnbb-content:media arg-data))
  ('GET "/contact" (cnbb-content:contact arg-data))
  ;; Misc
  ('GET "/favicon.ico" (cnbb-content:icon-redirect arg-data))
  ('GET "/relation/:userid/:accountid"
        (cnbb-tmpls:get-content userid accountid arg-data))
  ;; Not Found
  ('NOTFOUND
   (let* ((joined-path (++ "/" (string:join path "/")))
          (msg (++ "Unmatched route!~n~n"
                   "Path-info: ~p~n"
                   "joined path: ~p~n"
                   "arg-data: ~p~n~n"))
          (msg-args `(,path ,joined-path ,arg-data)))
     (logjam:info (MODULE) 'routes/3 "Not found: ~p" `(,joined-path))
     (logjam:error (MODULE) 'routes/3 msg msg-args)
     (cnbb-content:four-oh-four
      (++ (strong "Unmatched Route: ") joined-path)))))

