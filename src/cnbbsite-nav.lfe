(defmodule cnbbsite-nav
  (export all))

(include-lib "deps/exemplar/include/html-macros.lfe")

;;; Top nav

(defun top-nav ()
  (top-menu-group '(("/" "Home")
                    ("/books" "Books")
                    ("/books/upcoming" "Coming Soon")
                    ("/books/buy" "Purchasing")
                    ("/about" "About"))))

(defun top-menu-group (items)
  (nav '(class "navbar navbar-top" role "navigation")
    (div '(class "container")
      (div '(class "navbar-header")
        (list
          (get-logo)
          (div '(class "collapse navbar-collapse navbar-ex1-collapse")
            (ul '(class "nav navbar-nav navbar-right")
                (lists:map #'top-menu-item/1 items))))))))

(defun top-menu-item
  ((`(,path ,name))
   (li (a `(href ,path) name))))

(defun get-logo ()
  (img '(src "/images/logo-1.6-long-3-x50.png"
         class "navlogo")))

;;; Side nav

(defun side-nav ()
  (main-menu-group '((#(group-name "Books")
                      #(links (#("New Releases" "/books/new-releases" false)
                               #("Popular" "/books/popular" false)
                               #("Up-coming" "/books/upcoming" false)
                               #("All" "/books/all" false)
                               #("Where to Buy" "/books/buy" false))))
                     (#(group-name "Genres")
                      #(links (#("Historical Fiction" "/genres/hf" true)
                               #("Reference" "/genres/ref" false)
                               #("Science Fiction" "/genres/sf" false)
                               #("Technical" "/genres/tech" false)
                               #("Young Adult" "/genres/ya" false))))
                     (#(group-name "Authors")
                      #(links (#("Alice" "/authors/alice" false)
                               #("Bob" "/authors/bob" false)
                               #("Carol" "/authors/carol" false)))))))

(defun main-menu-group (sections)
  (div '(class "panel-group" role "tablist")
       (lists:map #'main-menu-section/1 sections)))

(defun main-menu-section
  ((`(#(group-name ,name) #(links ,items)))
   (div '(class "panel panel-default")
     (list
       (div `(class "panel-heading" role "tab" id ,(++ name "GroupHeading"))
         (h4 '(class "panel-title" id "-collapsible-list-group-")
           (a `(class "collapsed" data-toggle "collapse" href ,(++ "#" name "Group")
                aria-expanded "false" aria-controls ,(++ name "Group"))
              name)))
       (div `(id ,(++ name "Group") class "panel-collapse collapse" role "tabpanel"
              aria-labelledby ,(++ name "GroupHeading") aria-expanded "false"
              style "height: 0px;")
         (ul '(class "list-group")
           (lists:map #'main-menu-item/1 items)))))))

(defun main-menu-item
  ((`#(,name ,path ,active?))
   (li `(class ,(++ "list-group-item" (highlight active?)))
       (a `(href ,path) name))))

;;; Bottom nav

(defun bottom-nav ()
  (bottom-menu-group '(("/about" "About")
                       ("http://cnbbooks.blogspot.com" "Blog")
                       ("/media" "Media")
                       ("/books/buy" "How to Order"))))

(defun bottom-menu-group (items)
  (div '(class "bottom-nav")
    (string:join
      (lists:map #'bottom-menu-item/1 items)
      " | ")))

(defun bottom-menu-item
  ((`(,path ,name))
   (a `(href ,path) name)))

;;; Nav utility functions

(defun highlight (active)
  (if active
    " active"
    ""))