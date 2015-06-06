(defmodule cnbbsite-content
  (export all))

(include-lib "deps/exemplar/include/html-macros.lfe")

;;; Page-returning functions

;; Home Page

(defun home-page (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "Home")
      #(subtitle "Introduction")
      #(content ,(get-home-page-content)))
    arg-data))

;; Books

(defun books (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "Books")
      #(content ""))
    arg-data))

(defun books-new (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "New Books")
      #(content ""))
    arg-data))

(defun books-popular (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "Popular Books")
      #(content ""))
    arg-data))

(defun books-all (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "All Books")
      #(content ""))
    arg-data))

(defun books-upcoming (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "Upcoming Books")
      #(content ""))
    arg-data))

(defun books-buy (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "Buying Our Books")
      #(content ""))
    arg-data))

(defun book (isbn arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "[book title]")
      #(content ,(++ "[ISBN: " isbn)))
    arg-data))

;; Genres

(defun genres (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "Genres")
      #(content ""))
    arg-data))

(defun genre (id arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title ,(get-genre id))
      #(content ""))
    arg-data))

;; Authors

(defun authors (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "Authors")
      #(content ""))
    arg-data))

(defun author (id arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "[author name]")
      #(content ,(++ "[id: " id " ]")))
    arg-data))

;; Company

(defun about (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "About Cowboys 'N Beans")
      #(content ""))
    arg-data))

(defun media (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "Media")
      #(content ""))
    arg-data))

(defun contact (arg-data)
  (cnbbsite-templates:get-sidebar-content
    `(#(title "Contact")
      #(content ""))
    arg-data))

;;; Content-returning functions

(defun get-home-page-content ()
  "This is the placeholder text for the Home page.")

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

(defun get-genre
  (("hf") "Historical Fiction")
  (("ref") "Reference")
  (("sf") "Science Fiction")
  (("tech") "Technical")
  (("ya") "Young Adult")
  ((_) "Unknown Genre"))