(defmodule cnbbsite-content
  (export all))

(include-lib "deps/exemplar/include/html-macros.lfe")

(defun get-content-sections (remaining)
  (main
   (list
    (cnbbsite-nav:get-navbar)
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
              (div '(class "row well")
                   (get-footer-content))))
    (div '(class "section" id "subfooter")
         (div '(class "container")
              (div '(class "row text-right")
                   (get-subfooter-content))))
    (footer '(class "sticky-footer")
            (div '(class "container text-center")
                 (get-sticky-footer-content))))))

(defun get-sidebar-content (arg-data)
  "1-arity content API function.

  This function generates its HTML from scratch."
  (let ((title "Main Page"))
    (lfest-html-resp:ok
        (cnbbsite-templates:base-sidebar-page
          title
          (div '(class "col-md-3 col-sm-4 sidebar")
            (ul '(class "nav nav-stacked nav-pills")
              (cnbbsite-nav:get-main-nav)))
          (div
            (list
              (h1 title)
              (h2 "Introduction")
              (div
                (p "This is the main page. Links are to the left."))))))))

(defun get-content (item-id arg-data)
  "2-arity content API.

  This function generates its HTML from scratch."
  ;; we'll pretent to pull content from a data store here ...
  (let ((fetched-title "Queried Title")
        (fetched-content "Some super-great queried lorem ipsum."))
    (lfest-html-resp:ok
      (cnbbsite-templates:base-page
        fetched-title
        (div
          (list
            (h1 fetched-title)
            (h2 (++ "Item " item-id))
            (div (p fetched-content))))))))

(defun get-subheader-content ()
  (div '(class "subheader")
    (div '(class "social")
      (list
        (a '(href "http://twitter.com/CNBBooks") (span '(class "icon-twitter")))
        (span "&nbsp")
        (span '(class "icon-rss"))))))

(defun get-content (user-id account-id arg-data)
  "3-arity content API.

  This function generates its HTML by calling another function. This is an
  example of how one could do templating -- including putting HTML-generating
  functions in their own modules."
  ;; we'll pretent to pull content from a data store here ...
  (let ((fetched-title "Queried Title")
        (fetched-content "Some super-great queried lorem ipsum."))
    (lfest-html-resp:ok
      (cnbbsite-templates:base-page
        fetched-title
        (div
          (list
            (h1 fetched-title)
            (h2 (++ "Relation: "
                    user-id " (user id) | "
                    account-id " (account id)"))
            (div (p fetched-content))))))))

(defun get-footer-content ()
  "About | Blog | Media | How to Order")

(defun get-subfooter-content ()
  (div '(class "subfooter")
    (div '(class "social")
      (list
        (span '(class "icon-newspaper"))
        (span "&nbsp")
        (a '(href "http://twitter.com/CNBBooks") (span '(class "icon-twitter")))
        (span "&nbsp")
        (span '(class "icon-rss"))))))

(defun get-sticky-footer-content ()
  (div '(class "subfooter")
       (span '(class "copyright")
             "&copy; 2015 Cowboys 'N Beans Books")))

(defun icon-redirect (_arg-data)
  #(redirect_local "/images/favicon.png"))

(defun four-oh-four (message)
  "Custom 404 page."
    (lfest-html-resp:not-found
      (cnbbsite-templates:base-page
        "404"
        (div
          (list
            (h1 "404 - Not Found")
            (div (p message)))))))




