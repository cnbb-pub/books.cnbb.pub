(include-lib "exemplar/include/html-macros.lfe")

(defmacro defelemalias (alias tag)
  `(progn
     (defun ,alias ()
       (lists:flatten
        (exemplar-html-util:make-html (atom_to_list ',tag))))
     (defun ,alias (content)
       (lists:flatten
        (exemplar-html-util:make-html (atom_to_list ',tag) content)))
     (defun ,alias (attrs content)
       (lists:flatten
        (exemplar-html-util:make-html (atom_to_list ',tag) attrs content)))))

(defelemalias heading1 h3)
(defelemalias heading2 h4)
(defelemalias heading3 h5)
(defelemalias heading4 h6)
