;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "saucecodepro nerd font" :size 15 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "saucecodepro nerd font" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq roam-directory "~/org/roam")

(setq org-journal-date-prefix "#+TITLE: ")
(setq org-journal-time-prefix "* ")
(setq org-journal-date-format "%a, %Y-%m-%d")
(setq org-journal-file-format "%Y-%m-%d.org")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(use-package clojure-mode
  :config
  (define-clojure-indent
    (for-all 1)
    (prop/for-all 1)
    (statsd/time! 1))
  (setq clojure-align-forms-automatically t)
  (setq clojure-indent-style 'align-arguments)
  (add-to-list 'clojure-align-binding-forms "prop'/for-all"))

(after! magit
  (setq magit-save-repository-buffers 't))

(use-package lsp-mode
  :config
  (setq lsp-file-watch-threshold 100000)
  (push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\|map\\|svg\\|manifest\\|class\\)$" lsp-file-watch-ignored-files)
  (setq lsp-file-watch-ignored-directories (append lsp-file-watch-ignored-directories '("[/\\\\]\\.circleci\\'"
                                                                                        "[/\\\\]\\.clj-kondo\\'"
                                                                                        "[/\\\\]\\.github\\'"
                                                                                        "[/\\\\]\\.lsp\\'"
                                                                                        "[/\\\\]\\.node_modules\\'"
                                                                                        "[/\\\\]\\.rebl\\'"
                                                                                        "[/\\\\]\\.storybook\\'"
                                                                                        "[/\\\\]\\.shadow-cljs\\'"
                                                                                        "[/\\\\]\\resources/public/js\\'"
                                                                                        "[/\\\\]\\resources/public/css\\'"
                                                                                        "[/\\\\]\\classes\\'"
                                                                                        "[/\\\\]target\\'")))
  (setq lsp-ui-sideline-show-code-actions nil)
  ;; https://github.com/hlissner/doom-emacs/issues/3267#issuecomment-643569242
  (remove-hook 'doom-first-buffer-hook #'ws-butler-global-mode))

(map!
  :map smartparens-mode-map
  ;; smartparens maps (navigation ops)
  :nvie "C-M-f" #'sp-forward-sexp
  :nvie "C-M-b" #'sp-backward-sexp
  :nvie "C-M-u" #'sp-backward-up-sexp
  :nvie "C-M-d" #'sp-down-sexp
  ;; smartparens maps (split join slurp barf)
  :nie "M-s" #'sp-split-sexp
  :nie "M-j" #'sp-join-sexp
  :nvie "C->" #'sp-forward-slurp-sexp
  :nvie "C-<" #'sp-forward-barf-sexp
  :nvie "C-{" #'sp-backward-slurp-sexp
  :nvie "C-}" #'sp-backward-barf-sexp)
