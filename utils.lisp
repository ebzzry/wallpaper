;;;; utils.lisp

(uiop:define-package #:wallpaper/utils
  (:use #:cl
        #:marie))

(in-package #:wallpaper/utils)

(def err (message)
  "Exit with MESSAGE."
  (uiop:die 1 (format t "Error: ~A~%" message)))

(def apply-args (function options args)
  "Apply FUNCTION to ARGS."
  (apply function (append (list options) args)))

(def apply-args-1 (function args &key (options nil))
  "Apply FUNCTION to ARGS."
  (apply function (append options args)))
