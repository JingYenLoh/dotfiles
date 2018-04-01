;;; config.el -*- lexical-binding: t; -*-

;; Default settings
(setq-default tab-width 2
              js-indent-level 2
              indent-tabs-mode nil)

;; Set variables
(setq doom-line-numbers-style 'relative

      ;; Respect window managers
      frame-resize-pixelwise t

      ;; Org settings
      org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELED(c@/!)"))
      ;; Tags
      org-tag-alist (quote (("Errand"   . ?e)
                            ("Office"   . ?o)
                            ("Home"     . ?h)
                            ("School"   . ?s)
                            ("Learn"    . ?l)
                            (:newline)
                            ("WAITING"  . ?w)
                            ("HOLD"     . ?H)
                            ("CANCELED" . ?c)))
      org-fast-tag-selection-single-key nil
      ;; Refiling
      org-refile-use-outline-path 'file
      org-outline-path-complete-in-steps nil
      org-refile-allow-creating-parent-nodes 'confirm
      org-refile-targets '(("Next.org"     :level    . 0)
                           ("Someday.org"  :level    . 0)
                           ("Projects.org" :maxlevel . 1))
      ;; Capturing
      org-capture-templates
      '(("i" "inbox" entry (file "~/Dropbox/org/Inbox.org")
         "* TODO %?")
        ("g" "Google calendar" entry (file "~/Dropbox/org/Calendar.org")
         "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")))

;; Use fd for escaping in evil. Doom defaults to jk
(after! evil-escape
  (setq evil-escape-key-sequence "fd"))
