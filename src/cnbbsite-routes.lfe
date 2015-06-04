(defmodule cnbbsite-routes
  (export all))

(include-file "deps/exemplar/include/html-macros.lfe")
(include-file "deps/lfest/include/macros.lfe")

(defroutes
  ('GET "/"
        (cnbbsite-content:get-sidebar-content arg-data))
  ('GET "/favicon.ico"
        (cnbbsite-content:icon-redirect arg-data))
  ('GET "/content/:id"
        (cnbbsite-content:get-content id arg-data))
  ('GET "/relation/:userid/:accountid"
        (cnbbsite-content:get-content userid accountid arg-data))
  ;; When nothing matches, do this
  ('NOTFOUND
   (let* ((joined-path (++ "/" (string:join path "/")))
          (msg (++ "Unmatched route!~n~n"
                   "Path-info: ~p~n"
                   "joined path: ~p~n"
                   "arg-data: ~p~n~n"))
          (msg-args `(,path ,joined-path ,arg-data)))
     (logjam:error (MODULE) 'routes/3 msg msg-args)
     (cnbbsite-content:four-oh-four
      (++ (strong "Unmatched Route: ") joined-path)))))

