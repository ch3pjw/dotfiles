(require 'package)
(add-to-list 'package-archives
	'("melpa" . "http://melpa.org/packages/") t)
(setq package-enable-at-startup nil) ; To avoid initializing twice

; Makes MELPA package stuff available in this file
(package-initialize)

; UI stuff:
(setq viper-mode t)
(require 'viper)

(require 'evil)
(evil-mode 1)

(menu-bar-mode -1)
(require 'ido)
(ido-mode t)

(setq scroll-step 1)
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))

(require 'auto-complete)
(global-auto-complete-mode 1)

; General file editing preferences
(global-linum-mode 1)
(global-hl-line-mode 1)
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
 '(hl-line ((t (:background "grey15"))))
 '(linum ((t (:inherit shadow :background "grey15"))))
 '(region ((t (:background "color-17"))))
 '(shadow ((t (:foreground "grey60")))))
