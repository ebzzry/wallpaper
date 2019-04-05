#-asdf3.1 (error "ASDF 3.1 or bust!")

(defpackage :wallpaper-system
  (:use #:cl #:asdf))

(in-package #:wallpaper-system)

(defsystem :wallpaper
  :name "wallpaper"
  :version "0.0.1"
  :description "Wallpaper"
  :license "CC0"
  :author "Rommel MARTINEZ <ebzzry@ebzzry.io>"
  :class :package-inferred-system
  :depends-on ((:version "cl-scripting" "0.1")
               (:version "inferior-shell" "2.0.3.3")
               (:version "fare-utils" "1.0.0.5")
               #:mof
               "wallpaper/utils"
               "wallpaper/wallpaper"))
