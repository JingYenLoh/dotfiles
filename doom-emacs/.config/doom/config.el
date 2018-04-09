;;; config.el -*- lexical-binding: t; -*-

;; Default settings
(setq-default tab-width 2
              js-indent-level 2
              indent-tabs-mode nil)

;; Set variables
(setq doom-line-numbers-style 'relative

      ;; macOS
      default-frame-alist
      '((ns-transparent-titlebar . t)
        (ns-appearance           . 'nil))

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

;; Keybindings
(map!
 ;; localleader
 :m "," nil
 (:leader
   (:prefix "o"
     :desc  "APP: Calendar" :n "C" #'+calendar/open-calendar
     :desc  "APP: Agenda"   :n "A" #'org-agenda-list)))

;; org-super-agenda setup
(def-package! org-super-agenda
  :commands org-super-agenda-mode
  :config
  (setq org-super-agenda-groups
        '((:log t)
          (:name "Schedule"
                 :time-grid t)
          (:name "Today"
                 :scheduled today)
          (:name "Due today"
                 :deadline today)
          (:name "Overdue"
                 :deadline past)
          (:name "Soon"
                 :deadline future)
          (:name "Waiting"
                 :todo "WAITING"))))

(after! org-agenda
  (org-super-agenda-mode))

;; lang/org
(add-hook! 'org-mode-hook #'auto-fill-mode)
(after! org
  (map! :map evil-org-mode-map
        (:localleader
          :n "," #'org-ctrl-c-ctrl-c
          :n "*" #'org-ctrl-c-star
          :n "-" #'org-ctrl-c-minus
          :n "'" #'org-edit-special

          :n "a" #'org-agenda

          :n "A" #'org-attach

          (:desc "toggle" :prefix "t"
            :n "c" #'org-toggle-checkbox
            :n "e" #'org-toggle-pretty-entities
            :n "i" #'org-toggle-inline-images
            :n "l" #'org-toggle-link-display
            :n "t" #'org-todo
            :n "x" #'org-toggle-latex-fragment)

          (:desc "deadline" :prefix "d"
            :n "d" #'org-deadline
            :n "s" #'org-schedule
            :n "t" #'org-time-stamp
            :n "T" #'org-time-stamp-inactive)

          )))
