;;;; utils.lisp

(uiop:define-package #:wallpaper/utils
    (:use #:cl
          #:uiop
          #:inferior-shell
          #:cl-scripting
          #:fare-utils
          #:cl-ppcre
          #:cl-launch/dispatch)
  (:export #:err
           #:apply-args
           #:apply-args-1))

(in-package #:wallpaper/utils)

(defun err (message)
  "Exit with MESSAGE."
  (die 1 (format t "Error: ~A~%" message)))

(defun apply-args (function options args)
  "Apply FUNCTION to ARGS."
  (apply function (append (list options) args)))

(defun apply-args-1 (function args &key (options nil))
  "Apply FUNCTION to ARGS."
  (apply function (append options args)))
