;; Quicklisp

(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

;; Evil mode

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; Evil dependencies

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Use undo-fu for undo/redo
(unless (package-installed-p 'undo-fu)
  (package-install 'undo-fu))
(use-package evil
         :init
         (setq evil-undo-system 'undo-fu))
(use-package undo-fu)

;; Use goto-chg for g, ., etc.
(unless (package-installed-p 'goto-chg)
  (package-install 'goto-chg))
(require 'goto-chg)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
