
					;(load-file "~/doc/php-mode.el")
;;(set-foreground-color "brightwhite")

;https://code.google.com/p/gnuemacscolorthemetest/
(add-to-list 'load-path "~/.petrum/color-theme-6.6.0")
(add-to-list 'load-path "~/.petrum/color-theme-6.6.0/themes")
(load-file "~/.petrum/color-theme-6.6.0/color-theme.el")
(require 'color-theme)
(color-theme-initialize)
(color-theme-hober)
;(color-theme-comidia)

(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(setq next-line-add-newlines nil)
(setq require-final-newline nil)
(setq line-number-mode t)
(setq column-number-mode t)
(setq show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)
(delete-selection-mode 1)

(setq default-tab-width -8)
(mouse-wheel-mode 1)
(setq fill-column 80)
(setq make-backup-files nil)
(setq visible-bell t)
(setq scroll-step 1)
(xterm-mouse-mode 1)
(set-scroll-bar-mode 'right)

(defun beginning-of-line-smart ()
  "It moves the prompt at the beggining of the line in the Visual Studio way.
       some text here
^     ^        ^
A     B        C
Starting from 'C' you end in 'B' or 'A'"
  (interactive)
  (let ((A)(B)(C))
    (setq C (what-cursor-position))
    (beginning-of-line-text)
    (setq B (what-cursor-position))
    (beginning-of-line)
    (setq A (what-cursor-position))
    (if (equal A B) (beginning-of-line) (if (equal B C) (beginning-of-line) (beginning-of-line-text)))
    )
  ;(clear-message)
  (message "")
  )

(global-set-key [home] 'beginning-of-line-smart)
;(global-set-key [end] 'end-of-line)

(global-set-key [f2] 'switch-to-other-buffer)
(global-set-key [f3] 'my-switch-to-buffer)
(global-set-key [f4] 'next-error)
(global-set-key [f5] 'load-my-init-file)

(defun load-my-init-file ()
  "Load the initialization file."
  (interactive)
  (load-file "~/.emacs")
  )

(defun switch-to-other-buffer ()
  "Switch to topmost non-visible buffer. On default bindings, same as
 C-x b RET. The buffer selected is the one returned by (other-buffer)."
  (interactive)
  (switch-to-buffer (other-buffer)))
