(require 'package)
(add-to-list 'package-archives
	'("melpa" . "http://melpa.org/packages/") t)
(setq package-enable-at-startup nil) ; To avoid initializing twice

; Makes MELPA package stuff available in this file
(package-initialize)

; use-package will automatically handle installing missing packages
(if (not (package-installed-p 'use-package))
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)

; UI stuff:
(use-package windresize
  :ensure windresize)
(use-package evil
  :ensure evil
  :config (evil-mode 1))
(defun my-esc (prompt)
  "Evil insert state esc == C-g binding"
  (cond
   ;; If we're in an Evil state that defines [escape], return [escape] so that
   ;; Key Lookup will use it:
   ((or (evil-insert-state-p) (evil-normal-state-p) (evil-replace-state-p)
        (evil-visual-state-p)) [escape])
   (t (kbd "C-g"))))
; Define some useful vim-like key bindings, and bindings to get around annoying
; terminal <esc> key -> alt-key behaviour:
(define-prefix-command 'my-window-map)
(global-set-key (kbd "C-w") 'my-window-map)
(define-key my-window-map (kbd "<left>") 'windmove-left)
(define-key my-window-map (kbd "<right>") 'windmove-right)
(define-key my-window-map (kbd "<up>") 'windmove-up)
(define-key my-window-map (kbd "<down>") 'windmove-down)
(define-key my-window-map (kbd "%") 'split-window-right)
(define-key my-window-map (kbd "\"") 'split-window-below)
(define-key my-window-map (kbd "RET") 'windresize)
(define-key key-translation-map (kbd "C-g") 'my-esc)
(define-key evil-operator-state-map (kbd "C-g") 'keyboard-quit)
(add-to-list 'evil-emacs-state-modes 'git-rebase-mode)
(add-to-list 'evil-emacs-state-modes 'git-commit-mode)

(global-set-key (kbd "<f8>") 'flymake-goto-next-error)
(global-set-key (kbd "S-<f8>") 'flymake-goto-prev-error)


(menu-bar-mode -1)
(use-package ido
  :ensure ido
  :config (ido-mode t))
(savehist-mode 1)

(setq
  scroll-step 1
  scroll-conservatively 100000
  scroll-preserve-screen-position 1)
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))

(use-package auto-complete
  :ensure auto-complete
  :config (global-auto-complete-mode 1))

; General file editing preferences
(global-linum-mode 1)
(global-hl-line-mode 1)

(column-number-mode 1) ; in mode line
(use-package column-enforce-mode
  :ensure column-enforce-mode
  :config (global-column-enforce-mode 1))
(use-package fill-column-indicator
  :ensure fill-column-indicator)
; fci-mode doesn't provide its own global setting
(define-globalized-minor-mode global-fci-mode fci-mode turn-on-fci-mode)
(global-fci-mode 1)
(setq-default fill-column 80)
(setq fci-rule-character ?│)
(setq fci-rule-character-color "grey15")

(setq-default indent-tabs-mode nil)
; (global-git-gutter-mode +1)

(setq-default show-trailing-whitespace t)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

; Language/tool related modes:
;; (use-package git-commit-mode
;;   :ensure git-commit-mode)
;; (use-package git-rebase-mode
;;   :ensure git-rebase-mode)

(use-package dockerfile-mode
  :ensure dockerfile-mode)

(use-package elpy
  :ensure elpy
  :config (elpy-enable))
(add-hook 'python-mode-hook (lambda () (auto-complete-mode -1)))

(use-package cython-mode
  :ensure cython-mode)

(use-package haskell-mode
  :ensure haskell-mode)

(use-package go-mode
  :ensure go-mode)

(use-package coffee-mode
  :ensure coffee-mode
  :init (add-to-list 'auto-mode-alist '("\\.cjsx$" . coffee-mode)))

(use-package jinja2-mode
  :ensure jinja2-mode
  :init (add-to-list 'auto-mode-alist '("\\.j2$" . jinja2-mode)))

(use-package markdown-mode
  :ensure markdown-mode)

(use-package yaml-mode
  :ensure yaml-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-C-w-in-emacs-state t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:inherit diff-changed :foreground "green"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "red"))))
 '(error ((t (:foreground "color-161" :weight bold))))
 '(hl-line ((t (:background "grey15"))))
 '(linum ((t (:inherit shadow :background "grey15"))))
 '(region ((t (:background "color-17"))))
 '(shadow ((t (:foreground "grey60"))))
 '(trailing-whitespace ((t (:inherit error :inverse-video t))))
 '(viper-minibuffer-insert ((t (:inherit custom-comment))) t))
