;; .emacs

;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables packaging support
(require 'package)

(setq package-check-signature nil)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

;; Set up the package-quickstart feature for faster startup
;; (setq package-quickstart t)
(package-quickstart-refresh)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Setup some better Emacs defaults
    material-theme                  ;; Theme
    auto-highlight-symbol
    auto-complete
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; ====================================
;; Basic Customization
;; ====================================

(setq inhibit-startup-message t)  ;; Hide the startup message
(load-theme 'material t)          ;; Load material theme
;; (global-linum-mode t)             ;; Enable line numbers globally
(global-display-line-numbers-mode 1)

(setq-default system-name "UMassAmherst")
(setq-default user-full-name "VuLe")

(setq-default author (concat user-full-name "@" system-name)) 
(setq-default editor (concat user-full-name "@" system-name))


;; (load-theme 'dracula t)

;; If there are no archived package contents, refresh them
;; activate all packages
;; fetch the list of packages available

;; fullscreen at startup time
(add-hook 'window-setup-hook' toggle-frame-maximized t)
;; disable menu bar at start up
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; enable electric pair mode
(electric-pair-mode 1)
;; (global-display-line-numbers-mode 1)
(show-paren-mode 1)
(global-auto-highlight-symbol-mode 1)
(global-visual-line-mode t)
(column-number-mode 1)
(setq-default fill-column 79)
;; (add-hook 'prog-mode-hook #'auto-fill-mode)

(setq inhibit-startup-message t)   ;; hide the startup message
;; (load-theme 'material t)           ;; load material theme
;; (global-linum-mode t)              ;; enable line numbers globally
(setq linum-format "%4d \u2502 ")  ;; format line number spacing

;; Allow hash to be entered 

(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;; set key binding for backward delete to Ctrl + J
(global-set-key (kbd "C-h") 'backward-delete-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-j") 'newline)
;; revert buffer by C-c r
(global-set-key (kbd "C-c r") 'revert-buffer)

;; This code section is for preventing generating ~ files
(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Auto save after 10 seconds
(global-auto-revert-mode t)
(auto-save-visited-mode t)
(setq auto-save-interval 5)
(global-auto-revert-mode t)
(setq auto-revert-interval 5)

; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

(defun file-header ()
  "Add a header to Python files."
  (interactive)
  (when (not (file-exists-p buffer-file-name))
    (goto-char (point-min))
    (setq modified-time (format-time-string "%Y-%m-%d %H:%M"))
    (when (or (equal major-mode 'python-mode)
	      ;; (equal major-mode 'java-mode)
	      (equal major-mode 'c-mode))
      (insert (concat "\"\"\"\n"
		      (file-name-nondirectory buffer-file-name)
		      "\nCreated: "
		      modified-time
		      "\nAuthor: "
		      author
		      "\nLast updated: "
		      modified-time
		      "\nLast modified by: "
		      editor
		      "\nLicense: © Copyright 2022-2024, Vu Le"
		      "\nDesc:"
		      "\n\"\"\"\n\n")))
    (when (or (eq major-mode 'tex-mode)
	      (eq major-mode 'latex-mode))
      (insert (concat "%% "
		      (file-name-nondirectory buffer-file-name)
		      "\n%% Created on: "
		      modified-time
		      "\n%% Author: "
		      author
		      "\n%% Last updated: "
		      modified-time
		      "\n%% Last modified by: "
		      editor
		      "\n\n")))))

(add-hook 'write-file-functions 'file-header)

(defun insert-update-header ()
  "Insert or update header with current date and time."
  (interactive)
  (when (and buffer-file-name
             (or (equal major-mode 'python-mode)
                 (equal major-mode 'java-mode)
                 (equal major-mode 'c-mode)
                 (equal major-mode 'tex-mode)
		 (equal major-mode 'latex-mode)
		 ))
    (let ((modified-time (format-time-string "%Y-%m-%d %H:%M:%S")))
      (save-excursion
        (goto-char (point-min))
        (cond ((re-search-forward "Last updated: \\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} [0-9]\\{2\\}:[0-9]\\{2\\}:[0-9]\\{2\\}\\)" nil t)
               (replace-match (concat "Last updated: " modified-time))))
	(goto-char (point-min))
	(cond ((re-search-forward "Last modified by: \\(.+\\)" nil t)
               (replace-match (concat "Last modified by: " author))))
	))))

(add-hook 'before-save-hook 'insert-update-header)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(auto-complete auto-highlight-symbol material-theme gnu-elpa-keyring-update flycheck elpy better-defaults)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
