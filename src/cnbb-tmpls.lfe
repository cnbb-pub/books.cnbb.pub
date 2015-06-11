(defmodule cnbb-tmpls
  (export all))

(include-lib "deps/exemplar/include/html-macros.lfe")

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
       (div content)))
     arg-data))))

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
       (div content)))
     arg-data))))

(defun base-sidebar-page (title sidebar remaining arg-data)
  (base-page
    title
    (list
      sidebar
      remaining)
    arg-data))

(defun base-page (title remaining arg-data)
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
          (get-content-sections remaining arg-data))))))

(defun get-css ()
  (list
    (link '(rel "stylesheet" href "/css/bootstrap-min.css"))
    (link '(rel "stylesheet" href "/css/bootstrap-spacelab-min.css"))
    (link '(rel "stylesheet" href "/css/styles.css"))))

(defun get-favicon ()
  (link '(rel "icon"
          type "image/png"
          href "/images/favicon.png")))

(defun get-content-sections (remaining arg-data)
  (main
   (list
    (cnbb-nav:top-nav)
    (get-subheader)
    ;;(get-bread arg-data)
    (get-main remaining)
    (get-footer)
    (get-subfooter)
    (get-stickyfooter)
    (get-js))))

(defun get-subheader ()
  (div '(class "section" id "subheader")
       (div '(class "container")
            (div '(class "row text-right")
                 (get-subheader-content)))))

(defun get-bread (arg-data)
  (div '(class "section" id "subheader")
       (div '(class "container")
            (div '(class "row")
                 (get-bread-content arg-data)))))

(defun get-main (remaining)
  (div '(class "section" id "main")
       (div '(class "container")
            (div '(class "row well")
                 remaining))))

(defun get-footer ()
  (div '(class "section" id "footer")
       (div '(class "container")
            (div '(class "row well footer")
                 (get-footer-content)))))

(defun get-subfooter ()
  (div '(class "section" id "subfooter")
       (div '(class "container")
            (div '(class "row text-right")
                 (get-subfooter-content)))))

(defun get-stickyfooter ()
  (footer '(class "sticky-footer")
          (div '(class "container text-center")
               (get-sticky-footer-content))))

(defun get-subheader-content ()
  (div '(class "subheader")
    (div '(class "social")
      (list
        (a `(href ,(cnbb-const:twitter)) (span '(class "icon-twitter")))
        (span "&nbsp")
        (a `(href ,(cnbb-const:blogfeed)) (span '(class "icon-rss")))))))

(defun get-bread-content (arg-data)
  (cnbb-nav:bread-nav arg-data))

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

