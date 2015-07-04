(defmodule cnbb-content
  (export all))

(include-lib "cnbbsite/include/cnbb-html.lfe")

;;; Page-returning functions

;; Home Page

(defun home-page (arg-data)
  (cnbb-tmpls:get-sidebar-content
    `(#(title "Home")
      #(subtitle "Introduction")
      #(content "This is the placeholder text for the Home page."))
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
      #(content ,(get-upcoming-content)))
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
    `(#(title ,(cnbb-const:short-name))
      #(subtitle "A Tale of Cowboys 'N Beans")
      #(content ,(get-about-content)))
    arg-data))

(defun media (arg-data)
  (cnbb-tmpls:get-content
    `(#(title ,(cnbb-const:short-name))
      #(subtitle "Media")
      #(content ,(get-media-content)))
    arg-data))

(defun contact (arg-data)
  (cnbb-tmpls:get-content
    `(#(title ,(cnbb-const:short-name))
      #(subtitle "Contact")
      #(content ,(get-contact)))
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

(defun get-content-dir ()
  (case (os:getenv "CNBB_CONTENT_DIR")
    ('false "/more-www/cnbb/content")
    (x x)))

(defun get-content-file (id)
  (filename:join
   (get-content-dir)
   (++ (atom_to_list id) ".html")))

(defun get-content (id)
  (case (file:read_file (get-content-file id))
    (`#(ok ,data)
     (binary_to_list data))
    (x
     x)))

(defun get-about-content ()
  (get-content 'about-cnbb))
  ;;(io_lib:format "~p" `(,(file:get_cwd))))

(defun get-media-content ()
  (list
    (list
     (heading1 "Text")
     (p (list
         (em "Long Name")
         ": Cowboys 'N Beans Books"))
     (p (list
         (em "Short Name")
         ": C&B|Books"))
     (p (list
        (em "Legal Name")
        ": Cowboys 'N Beans Books LLC")))
    (list
      (heading1 "Logos")
      (p "Click each logo below to download a high-resolution version.")
      (heading2 "Standard")
      (a '(href "/images/logos/logo-standard.png" target "_blank")
         (img '(src "/images/logos/logo-standard-thumb.png")))
      (heading2 "Square")
      (a '(href "/images/logos/logo-square.png" target "_blank")
         (img '(src "/images/logos/logo-square-thumb.png")))
      (heading2 "Long")
      (a '(href "/images/logos/logo-long.png" target "_blank")
         (img '(src "/images/logos/logo-long-thumb.png"))))))

(defun get-contact ()
  (list
   (heading1 "Email")
   (p "Email is probably the best way to reach us. There are several addresses below you may use, dependeing upon your needs.")
   (ul (list
        (li (list (em "General Information") ": " (a '(href "mailto:info@cnbbooks.co") "info@cnbbooks.co")))
        (li (list (em "Submissions") ": " (a '(href "mailto:submissions@cnbbooks.co") "submissions@cnbbooks.co")))))
   (heading1 "Address")
   (p (list "Cowboys 'N Beans Books LLC" (br) "PO Box 912" (br) "Lakefield, MN 56150" (br) "USA"))
   (heading1 "Social Media")
   (ul (list
        (li (list (a '(href "http://cnbbooks.blogspot.com/") "Blog")
                  " | ("
                  (a '(href "") "feed")
                  ") "))
        (li (a '(href "http://twitter.com/CNBBooks") "Twitter"))))
   (heading1 "Mail Lists")
   (p "")
   (ul (list
        (li (a '(href "https://groups.google.com/forum/#!forum/cnbbooks-announcements")
               "Announcements"))))))

(defun get-upcoming-content ()
  "")