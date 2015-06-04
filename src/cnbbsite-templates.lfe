(defmodule cnbbsite-templates
  (export all))

(include-lib "deps/exemplar/include/html-macros.lfe")

(defun base-page (title remaining)
  "A function to provide the base for all pages."
  (list
    (!doctype 'html)
    (html '(lang "en")
      (list
        (head
          (list
            (title (++ (cnbbsite-const:title-prefix)
                       title
                       (cnbbsite-const:title-postfix)))
            (get-css)
            (get-favicon)))
        (body
          (cnbbsite-content:get-content-sections
            remaining))))))

(defun get-css ()
  (list
    (link '(rel "stylesheet" href "/css/bootstrap-min.css"))
    (link '(rel "stylesheet" href "/css/bootstrap-spacelab-min.css"))
    (link '(rel "stylesheet" href "/css/styles.css"))))

(defun get-favicon ()
  (link '(rel "icon"
          type "image/png"
          href "/images/favicon.png")))

(defun base-sidebar-page (title sidebar remaining)
  "We can also make building HTML easier by using functions."
  (base-page title
    (list
      sidebar
      remaining)))
