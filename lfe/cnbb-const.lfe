(defmodule cnbb-const
  (export all))

(defun short-name () "C&B|Books")
(defun long-name () "Cowboys 'N Beans Books")
(defun legal-name () (++ (long-name) ", LLC"))
(defun copy-year () "2015")
(defun title-prefix () "")
(defun title-postfix () (++ " ~:~ " (short-name)))
(defun twitter () "http://twitter.com/CNBBooks")
(defun newslist () "https://groups.google.com/forum/#!forum/cnbbooks-announcements/join")
(defun blogfeed () "http://feeds.feedburner.com/CowboysNBeansBooks")
