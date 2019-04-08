;;;; wallpaper.lisp

(uiop:define-package #:wallpaper/wallpaper
    (:use #:cl
          #:cl-scripting
          #:uiop
          #:inferior-shell
          #:fare-utils
          #:optima
          #:optima.ppcre
          #:cl-launch/dispatch
          #:wallpaper/utils)
  (:export #:wallpaper))

(in-package :wallpaper/wallpaper)

(defun deco! (path url)
  (run/i `(curl "-s" "-o" ,path ,url))
  (run/i `(deco ,path))
  (success))

(defun random-line (lines)
  (setf *random-state* (make-random-state t))
  (nth (random (length lines)) lines))

(defun main (args)
  (let ((path (mof:home ".deco")))
    (flet ((f-chromecast ()
             (let* ((source "https://raw.githubusercontent.com/dconnolly/chromecast-backgrounds/master/README.md")
                    (lines (mapcar (lambda (line)
                                     (cl-ppcre:regex-replace-all "!\\[\\]\\((.*)\\)" line "\\1"))
                                   (run/lines `(curl "-sL" ,source)))))
               (deco! path (random-line lines))))
           (f-wallhaven ()
             (let* ((source "https://wallhaven.now.sh/random")
                    (url (run/ss `(curl "-sL" "-O" "-w" "%{url_effective}" ,source))))
               (uiop:delete-file-if-exists "random")
               (deco! path url))))
      (destructuring-bind (mode &rest z)
          args
        (match mode
             ((ppcre "(chromecast|cc)") (f-chromecast))
             ((ppcre "(wallhaven|wh)") (f-wallhaven))
             (_ (err (mof:fmt "invalid mode ~A~%" mode))))))))

(exporting-definitions
 (defun wallpaper (&rest args)
    "Canonical entry point"
    (apply #'main args)))

(register-commands :wallpaper/wallpaper)
