(defmodule cnbbsite-nav
  (export all))

(include-lib "deps/exemplar/include/html-macros.lfe")

(defun get-side-menu ()
  (list
    (li (a '(href "/") "Main Page"))
    (li (a '(href "/content/1") "/content/1"))
    (li (a '(href "/content/2") "/content/2"))
    (li (a '(href "/content/3") "/content/3"))
    (li
      (list
        (a '(href "/relation/1/2") "/relation/1/2")))
    (li (a '(href "/bob") '"404"))))

(defun get-navbar()
  (nav '(class "navbar navbar-top" role "navigation")
    (div '(class "container")
      (div '(class "navbar-header")
        (list
          (img '(src "/images/logo-1.6-long-3-x50.png"))
          (div '(class "collapse navbar-collapse navbar-ex1-collapse")
            (ul '(class "nav navbar-nav navbar-right")
              (get-side-menu))))))))

(defun get-main-nav ()
  (div '(class "panel-group" id "accordion" role "tablist" aria-multiselectable "true")
    (list
    ;; Menu item 1

    (div '(class "panel panel-default")
      (list
      (div '(class "panel-heading" role "navigation" id "headingBooks")
        (h4 '(class "panel-title") "Books"))
      (div '(id "collapseOne" class "panel-collapse collapse in" role "presentation" aria-labelledby "headingBooks")
        (div '(class "panel-body")
          (ul '(class "nav nav-pills nav-stacked")
            (list
              (li '(roll "presentation" class "active")
                  (a '(href "#") "New Releases"))
              (li '(roll "presentation" )
                  (a '(href "#") "Popular"))
              (li '(roll "presentation")
                  (a '(href "#") "All"))))))))

    ;; Menu item 2

    (div '(class "panel panel-default")
      (list
      (div '(class "panel-heading" role "tab" id "headingGenres")
        (h4 '(class "panel-title") "Genres"))
      (div '(id "collapseTwo" class "panel-collapse collapse in" role "tabpanel" aria-labelledby "headingGenres")
        (div '(class "panel-body")
          (ul '(class "nav nav-pills nav-stacked")
            (list
              (li '(roll "presentation" class "active")
                  (a '(href "#") "Historical Fiction"))
              (li '(roll "presentation" )
                  (a '(href "#") "Reference"))
              (li '(roll "presentation" )
                  (a '(href "#") "Science Fiction"))
              (li '(roll "presentation" )
                  (a '(href "#") "Technical"))
              (li '(roll "presentation")
                  (a '(href "#") "Young Adult"))))))))

    ;; Menu item 3

    (div '(class "panel panel-default")
      (list
      (div '(class "panel-heading" role "tab" id "headingAuthors")
        (h4 '(class "panel-title") "Authors"))
      (div '(id "collapseThree" class "panel-collapse collapse in" role "tabpanel" aria-labelledby "headingAuthors")
        (div '(class "panel-body")
          (ul '(class "nav nav-pills nav-stacked")
            (list
              (li '(roll "presentation" class "active")
                  (a '(href "#") "Alice"))
              (li '(roll "presentation" )
                  (a '(href "#") "Bob"))
              (li '(roll "presentation" )
                  (a '(href "#") "Carol"))
              (li '(roll "presentation" )
                  (a '(href "#") "Dave"))
              (li '(roll "presentation")
                  (a '(href "#") "Eve"))))))))

        )))

