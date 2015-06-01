(defmodule cnbbsite-util
  (export all))

(defun get-version ()
  (lutil:get-app-version 'cnbbsite))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(cnbbsite ,(get-version)))))
