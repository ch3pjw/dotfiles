(require 'package)
(add-to-list 'package-archives
	'("melpa" . "http://melpa.org/packages/") t)
(setq package-enable-at-startup nil) ; To avoid initializing twice

; Makes MELPA package stuff available in this file
(package-initialize)

; UI stuff:
(require 'evil)
(evil-mode 1)

(menu-bar-mode -1)
(require 'ido)
(ido-mode t)
(savehist-mode 1)

(setq
  scroll-step 1
  scroll-conservatively 100000
  scroll-preserve-screen-position 1)
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))

(require 'auto-complete)
(global-auto-complete-mode 1)

; General file editing preferences
(global-linum-mode 1)
(global-hl-line-mode 1)

(column-number-mode 1) ; in mode line
(require 'column-enforce-mode)
(global-column-enforce-mode 1)
(add-hook 'python-mode-hook (lambda () (column-enforce-column 79)))
(require 'fill-column-indicator)
; fci-mode doesn't provide its own global setting
(define-globalized-minor-mode global-fci-mode fci-mode turn-on-fci-mode)
(global-fci-mode 1)
(setq-default fill-column 80)
(setq fci-rule-character ?│)
(setq fci-rule-character-color "grey15")

(show-smartparens-global-mode +1)
; (global-git-gutter-mode +1)

(add-to-list 'load-path "~/.emacs.d/go-mode.el")
(require 'go-mode-load)

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
 '(error ((t (:foreground "color-161" :weight bold))))
 '(hl-line ((t (:background "grey15"))))
 '(linum ((t (:inherit shadow :background "grey15"))))
 '(region ((t (:background "color-17"))))
 '(shadow ((t (:foreground "grey60"))))
 '(viper-minibuffer-insert ((t (:inherit custom-comment)))))
