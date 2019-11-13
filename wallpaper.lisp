;;;; wallpaper.lisp

(uiop:define-package #:wallpaper/wallpaper
    (:use #:cl
          #:cl-scripting
          #:inferior-shell
          #:fare-utils
          #:optima
          #:optima.ppcre
          #:cl-launch/dispatch
          #:wallpaper/utils)
  (:export #:wallpaper))

(in-package :wallpaper/wallpaper)

(defvar *base-path* (mof:home ".deco"))

(defvar *wallhaven-url* "https://wallhaven.cc/api/v1/search?sorting=random"
  "Source URL for Wallhaven interaction.")

(defun deco! (path url)
  (run/i `(curl "-s" "-o" ,path ,url))
  (run/i `(deco ,path))
  (success))

(defun random-line (lines)
  (setf *random-state* (make-random-state t))
  (nth (random (length lines)) lines))

(defvar +ascii-alphabet+
  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  "All letters in 7 bit ASCII.")

(defun random-string (&optional (length 32) (alphabet +ascii-alphabet+))
  "Returns a random alphabetic string.

The returned string will contain LENGTH characters chosen from the vector ALPHABET."
  (loop :with id = (make-string length)
        :with alphabet-length = (length alphabet)
        :for i :below length
        :do (setf (cl:aref id i)
                  (cl:aref alphabet (random alphabet-length)))
        :finally (return id)))

(defun slurp-file (path)
  "Read entire file as string."
  (uiop:read-file-string path))

(defun resolve-system-file (file system)
  "Return the path of FILE relative to current system."
  (uiop:merge-pathnames* file (asdf:system-source-directory (asdf:find-system system))))

(defun set-random-chromecast-wallpaper ()
  (let* ((lines (mapcar (lambda (line)
                          (cl-ppcre:regex-replace-all "!\\[\\]\\((.*)\\)" line "\\1"))
                        (cl-ppcre:split "\\s+"
                                        (slurp-file (resolve-system-file
                                                     "data/chromecast.txt"
                                                     :wallpaper))))))
    (deco! *base-path* (random-line lines))))

(defun fetch-random-wallhaven-image (url)
  "Fetch data from Wallhaven."
  (let* ((octets (drakma:http-request url))
         (json (flexi-streams:octets-to-string octets :external-format :utf-8)))
    (with-input-from-string (string json)
      (destructuring-bind (data metadata)
          (cl-json:decode-json string)
        (declare (ignore metadata))
        (let ((item (nth (random (length (rest data))) (rest data))))
          (loop :for i :in item
                :when (eql (first i) :path)
                :return (cdr i)))))))

(defun set-random-wallhaven-wallpaper ()
  "Fetch a random Wallhaven image then set it as the root image."
  (let ((url (fetch-random-wallhaven-image *wallhaven-url*)))
    (deco! *base-path* url)))

(defun main (args)
  (destructuring-bind (mode &rest z)
      args
    (declare (ignore z))
    (match mode
      ((ppcre "(chromecast|cc)") (set-random-chromecast-wallpaper))
      ((ppcre "(wallhaven|wh)") (set-random-wallhaven-wallpaper))
      (_ (err (mof:fmt "invalid mode ~A~%" mode))))))

(exporting-definitions
 (defun wallpaper (&rest args)
    "Canonical entry point"
    (apply #'main args)))

(register-commands :wallpaper/wallpaper)
