(defmodule cnbb-content
  (export all))

(include-lib "deps/exemplar/include/html-macros.lfe")

;;; Page-returning functions

;; Home Page

(defun home-page (arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "Home")
      #(subtitle "Introduction")
      #(content ,(cnbb-data:get-home-page-content)))
    arg-data))

;; Books

(defun books (arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "Books")
      #(content ""))
    arg-data))

(defun books-new (arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "New Books")
      #(content ""))
    arg-data))

(defun books-popular (arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "Popular Books")
      #(content ""))
    arg-data))

(defun books-all (arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "All Books")
      #(content ""))
    arg-data))

(defun books-upcoming (arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "Upcoming Books")
      #(content ""))
    arg-data))

(defun books-buy (arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "Buying Our Books")
      #(content ""))
    arg-data))

(defun book (isbn arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "[book title]")
      #(content ,(++ "[ISBN: " isbn)))
    arg-data))

;; Genres

(defun genres (arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "Genres")
      #(content ""))
    arg-data))

(defun genre (id arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "Genre")
      #(subtitle ,(cnbb-data:get-genre id))
      #(content ""))
    arg-data))

;; Authors

(defun authors (arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "Authors")
      #(content ""))
    arg-data))

(defun author (id arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "Author")
      #(subtitle "[author name]")
      #(content ,(++ "[id: " id " ]")))
    arg-data))

;; Company

(defun about (arg-data)
  (cnbb-tmpls:get-content
    `(#(title "About Cowboys 'N Beans")
      #(content ""))
    arg-data))

(defun media (arg-data)
  (cnbb-tmpls:get-content
    `(#(title "Media")
      #(content ""))
    arg-data))

(defun contact (arg-data)
  (cnbb-tmpls:get-content
    `(#(title "Contact")
      #(content ""))
    arg-data))

;;; Content-returning functions

(defun icon-redirect (_arg-data)
  #(redirect_local "/images/favicon.png"))

(defun four-oh-four (message)
  "Custom 404 page."
    (lfest-html-resp:not-found
      (cnbb-tmpls:base-page
        "404"
        (div
          (list
            (h1 "404 - Not Found")
            (div (p message)))))))
