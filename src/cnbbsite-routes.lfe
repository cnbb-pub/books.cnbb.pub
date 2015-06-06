(defmodule cnbbsite-routes
  (export all))

(include-lib "exemplar/include/html-macros.lfe")
(include-lib "lfest/include/macros.lfe")

(defroutes
  ('GET "/" (cnbbsite-content:home-page arg-data))
  ;; Books
  ('GET "/books" (cnbbsite-content:books arg-data))
  ('GET "/books/new-releases" (cnbbsite-content:books-new arg-data))
  ('GET "/books/popular" (cnbbsite-content:books-popular arg-data))
  ('GET "/books/all" (cnbbsite-content:books-all arg-data))
  ('GET "/books/upcoming" (cnbbsite-content:books-upcoming arg-data))
  ('GET "/books/buy" (cnbbsite-content:books-buy arg-data))
  ('GET "/books/:isbn" (cnbbsite-content:book isbn arg-data))
  ;; Genres
  ('GET "/genres" (cnbbsite-content:genres arg-data))
  ('GET "/genres/:id" (cnbbsite-content:genre id arg-data))
  ;; Authors
  ('GET "/authors" (cnbbsite-content:authors arg-data))
  ('GET "/authors/:id" (cnbbsite-content:author id arg-data))
  ;; Company
  ('GET "/about" (cnbbsite-content:about arg-data))
  ('GET "/media" (cnbbsite-content:media arg-data))
  ('GET "/contact" (cnbbsite-content:contact arg-data))
  ;; Misc
  ('GET "/favicon.ico" (cnbbsite-content:icon-redirect arg-data))
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
     (cnbbsite-content:four-oh-four
      (++ (strong "Unmatched Route: ") joined-path)))))

