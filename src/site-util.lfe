(defmodule site-util
  (export all))

(defun get-version ()
  (lutil:get-app-version 'site))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(site ,(get-version)))))
