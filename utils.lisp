;;;; utils.lisp

(uiop:define-package #:wallpaper/utils
  (:use #:cl
        #:marie))

(in-package #:wallpaper/utils)

(defun* (err t) (message)
  "Exit with MESSAGE."
  (die 1 (format t "Error: ~A~%" message)))

(defun* (apply-args t) (function options args)
  "Apply FUNCTION to ARGS."
  (apply function (append (list options) args)))

(defun* (apply-args-1 t) (function args &key (options nil))
  "Apply FUNCTION to ARGS."
  (apply function (append options args)))
