(defmodule cnbb-tmpls
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
            (title (++ (cnbb-const:title-prefix)
                       title
                       (cnbb-const:title-postfix)))
            (get-css)
            (get-favicon)))
        (body
          (get-content-sections remaining))))))

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
  (base-page title
    (list
      sidebar
      remaining)))

(defun get-content-sections (remaining)
  (main
   (list
    (cnbb-nav:top-nav)
    (div '(class "section" id "subheader")
         (div '(class "container")
              (div '(class "row text-right")
                   (get-subheader-content))))
    (div '(class "section" id "main")
         (div '(class "container")
              (div '(class "row well")
                   remaining)))
    (div '(class "section" id "footer")
         (div '(class "container")
              (div '(class "row well footer")
                   (get-footer-content))))
    (div '(class "section" id "subfooter")
         (div '(class "container")
              (div '(class "row text-right")
                   (get-subfooter-content))))
    (footer '(class "sticky-footer")
            (div '(class "container text-center")
                 (get-sticky-footer-content)))
    (get-js))))

(defun get-content
  ((`(#(title ,title) #(content ,content)) arg-data)
   (get-content
    `(#(title ,title) #(subtitle "") #(content ,content)) arg-data))
  ((`(#(title ,title) #(subtitle ,subtitle) #(content ,content)) arg-data)
   (lfest-html-resp:ok
    (base-page
     title
     (div
      (list
       (h1 title)
       (h2 subtitle)
       (div content)))))))

(defun get-sidebar-content
  ((`(#(title ,title) #(content ,content)) arg-data)
   (get-sidebar-content
    `(#(title ,title) #(subtitle "") #(content ,content)) arg-data))
  ((`(#(title ,title) #(subtitle ,subtitle) #(content ,content)) arg-data)
   (lfest-html-resp:ok
    (base-sidebar-page
     title
     (div '(class "col-md-3 col-sm-4 sidebar")
          (ul '(class "nav nav-stacked nav-pills")
              (cnbb-nav:side-nav arg-data)))
     (div
      (list
       (h1 title)
       (h2 subtitle)
       (div content)))))))

(defun get-subheader-content ()
  (div '(class "subheader")
    (div '(class "social")
      (list
        (a `(href ,(cnbb-const:twitter)) (span '(class "icon-twitter")))
        (span "&nbsp")
        (a `(href ,(cnbb-const:blogfeed)) (span '(class "icon-rss")))))))


(defun get-footer-content ()
  (cnbb-nav:bottom-nav))

(defun get-subfooter-content ()
  (div '(class "subfooter")
    (div '(class "social")
      (list
        (a `(href ,(cnbb-const:newslist)) (span '(class "icon-newspaper")))
        (span "&nbsp")
        (a `(href ,(cnbb-const:twitter)) (span '(class "icon-twitter")))
        (span "&nbsp")
        (a `(href ,(cnbb-const:blogfeed)) (span '(class "icon-rss")))))))

(defun get-js ()
  (list (script '(src "/js/jquery-1.11.3.min.js"))
        (script '(src "/js/bootstrap-min.js"))))

(defun get-sticky-footer-content ()
  (div '(class "subfooter")
       (span '(class "copyright")
             "&copy; 2015 Cowboys 'N Beans Books")))

