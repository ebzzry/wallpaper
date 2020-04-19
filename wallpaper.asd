#-asdf3.1 (error "ASDF 3.1 or bust!")

(defpackage :wallpaper-system
  (:use #:cl #:asdf))

(in-package #:wallpaper-system)

(defsystem :wallpaper
  :name "wallpaper"
  :version "1.0.0"
  :description "Wallpaper"
  :license "CC0"
  :author "Rommel MARTINEZ <rom@mimix.io>"
  :class :package-inferred-system
  :depends-on (#:cl-json
               #:flexi-streams
               #:drakma
               #:cl-ppcre
               #:marie
               "wallpaper/utils"
               "wallpaper/wallpaper"))
