Wallpaper
=========


<a name="toc">Table of contents</a>
-----------------------------------

- [Overview](#overview)
- [Installation](#installation)
- [Usage](#usage)


<a name="overview">Overview</a>
-------------------------------

Wallpaper is a small program that sets a random wallpaper from the
[Chromecast](https://en.wikipedia.org/wiki/Chromecast) and [Wallhaven](https://alpha.wallhaven.cc/)
sets.


<a name="installation">Installation</a>
---------------------------------------

Install the dependencies:

    nix-env -i sbcl gnumake cl-launch git curl deco

Then, install wallpaper:

```bash
mkdir -p ~/bin ~/common-lisp
git clone https://github.com/ebzzry/wallpaper ~/common-lisp/wallpaper
git clone https://github.com/ebzzry/mof ~/common-lisp/mof
curl -O https://beta.quicklisp.org/quicklisp.lisp
sbcl --load quicklisp.lisp --eval  '(quicklisp-quickstart:install)' --eval '(let ((ql-util::*do-not-prompt* t)) (ql:add-to-init-file) (ql:quickload :cl-launch) (sb-ext:quit))'
make -C ~/common-lisp/wallpaper install
```

Or, in one line:

```bash
mkdir -p ~/bin ~/common-lisp; git clone https://github.com/ebzzry/wallpaper ~/common-lisp/wallpaper; git clone https://github.com/ebzzry/mof ~/common-lisp/mof;  curl -O https://beta.quicklisp.org/quicklisp.lisp; sbcl --load quicklisp.lisp --eval  '(quicklisp-quickstart:install)' --eval '(let ((ql-util::*do-not-prompt* t)) (ql:add-to-init-file) (ql:quickload :cl-launch) (sb-ext:quit))'; make -C ~/common-lisp/wallpaper install
```


<a name="usage">Usage</a>
-------------------------

To set a random wallpaper from the Chromecast set:

    wallpaper chromecast

To set a random wallpaper from the Wallhaven set:

    wallpaper wallhaven
