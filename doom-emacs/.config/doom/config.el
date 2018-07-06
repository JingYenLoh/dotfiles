;;; config.el -*- lexical-binding: t; -*-

;; Default settings
(setq-default tab-width 2
              js-indent-level 2
              indent-tabs-mode nil)

;; (when (and
;;        (memq window-system '(mac ns))
;;        (>= emacs-major-version 27))
;;   default-frame-alist
;;   '((ns-transparent-titlebar . t)
;;     (ns-appearance           . 'nil)))

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
      org-log-done 'time
      org-log-into-drawer t
      org-log-state-notes-insert-after-drawers nil
      ;; Tags
      org-tag-alist (quote (("errand"   . ?e)
                            ("office"   . ?o)
                            ("home"     . ?h)
                            ("school"   . ?s)
                            ("learn"    . ?l)
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

(after! evil-snipe
  (setq evil-snipe-scope 'visible))

;; Keybindings
(map!
 (:leader
   (:prefix "o"
     :desc  "APP: Calendar" :n "C" #'+calendar/open-calendar
     :desc  "APP: Agenda"   :n "A" #'org-agenda-list)))

;; ;; org-super-agenda setup
;; (def-package! org-super-agenda
;;   :commands org-super-agenda-mode
;;   :config
;;   (setq org-super-agenda-groups
;;         '((:log t)
;;           (:name "Schedule"
;;                  :time-grid t)
;;           (:name "Today"
;;                  :scheduled today)
;;           (:name "Due today"
;;                  :deadline today)
;;           (:name "Overdue"
;;                  :deadline past)
;;           (:name "Soon"
;;                  :deadline future)
;;           (:name "Waiting"
;;                  :todo "WAITING"))))

;; (after! org-agenda
;;   (org-super-agenda-mode))

;; app/email
(after! mu4e
  (set-email-account! "gmail"
    '((user-email-address     . "lohjingyen@gmail.com")
      (mu4e-sent-folder       . "/gmail/Sent Mail")
      (mu4e-drafts-folder     . "/gmail/Drafts")
      (mu4e-trash-folder      . "/gmail/Trash")
      (mu4e-refile-folder     . "/gmail/All Mail")
      (smtpmail-smtp=user     . "lohjingyen@gmail.com")
      (mur3-compose-signature . "--\nJing Yen Loh")))

  ;; an evil-esque keybinding scheme for mu4e
  ;; Credits: hlissner
  (setq mu4e-view-mode-map (make-sparse-keymap)
        ;; mu4e-compose-mode-map (make-sparse-keymap)
        mu4e-headers-mode-map (make-sparse-keymap)
        mu4e-main-mode-map (make-sparse-keymap))

  (map! (:map (mu4e-main-mode-map mu4e-view-mode-map)
          :leader
          :n "," #'mu4e-context-switch
          :n "." #'mu4e-headers-search-bookmark
          :n ">" #'mu4e-headers-search-bookmark-edit
          :n "/" #'mu4e~headers-jump-to-maildir)

        (:map (mu4e-headers-mode-map mu4e-view-mode-map)
          :localleader
          :n "f" #'mu4e-compose-forward
          :n "r" #'mu4e-compose-reply
          :n "c" #'mu4e-compose-new
          :n "e" #'mu4e-compose-edit)

        (:map mu4e-main-mode-map
          :n "q"   #'mu4e-quit
          :n "u"   #'mu4e-update-index
          :n "U"   #'mu4e-update-mail-and-index
          :n "J"   #'mu4e~headers-jump-to-maildir
          :n "c"   #'+email/compose
          :n "b"   #'mu4e-headers-search-bookmark)

        (:map mu4e-headers-mode-map
          :n "q"   #'mu4e~headers-quit-buffer
          :n "r"   #'mu4e-compose-reply
          :n "c"   #'mu4e-compose-edit
          :n "s"   #'mu4e-headers-search-edit
          :n "S"   #'mu4e-headers-search-narrow
          :n "RET" #'mu4e-headers-view-message
          :n "u"   #'mu4e-headers-mark-for-unmark
          :n "U"   #'mu4e-mark-unmark-all
          :n "v"   #'evil-visual-line
          :nv "d"  #'+email/mark
          :nv "="  #'+email/mark
          :nv "-"  #'+email/mark
          :nv "+"  #'+email/mark
          :nv "!"  #'+email/mark
          :nv "?"  #'+email/mark
          :nv "r"  #'+email/mark
          :nv "m"  #'+email/mark
          :n  "x"  #'mu4e-mark-execute-all

          :n "]]"  #'mu4e-headers-next-unread
          :n "[["  #'mu4e-headers-prev-unread

          (:localleader
            :n "s" 'mu4e-headers-change-sorting
            :n "t" 'mu4e-headers-toggle-threading
            :n "r" 'mu4e-headers-toggle-include-related

            :n "%" #'mu4e-headers-mark-pattern
            :n "t" #'mu4e-headers-mark-subthread
            :n "T" #'mu4e-headers-mark-thread))

        (:map mu4e-view-mode-map
          :n "q" #'mu4e~view-quit-buffer
          :n "r" #'mu4e-compose-reply
          :n "c" #'mu4e-compose-edit
          :n "o" #'ace-link-mu4e

          :n "<M-Left>"  #'mu4e-view-headers-prev
          :n "<M-Right>" #'mu4e-view-headers-next
          :n "[m" #'mu4e-view-headers-prev
          :n "]m" #'mu4e-view-headers-next
          :n "[u" #'mu4e-view-headers-prev-unread
          :n "]u" #'mu4e-view-headers-next-unread

          (:localleader
            :n "%" #'mu4e-view-mark-pattern
            :n "t" #'mu4e-view-mark-subthread
            :n "T" #'mu4e-view-mark-thread

            :n "d" #'mu4e-view-mark-for-trash
            :n "r" #'mu4e-view-mark-for-refile
            :n "m" #'mu4e-view-mark-for-move))

        (:map mu4e~update-mail-mode-map
          :n "q" #'mu4e-interrupt-update-mail)))

;; lang/org
(map! (:after org
        :map evil-org-mode-map
        (:localleader
          :n "," #'org-ctrl-c-ctrl-c
          :n "*" #'org-ctrl-c-star
          :n "-" #'org-ctrl-c-minus
          :n "'" #'org-edit-special

          :n "a" #'org-agenda

          :n "A" #'org-attach

          :n "e" #'org-export-dispatch

          (:desc "insert" :prefix "i"
            :n "d" #'org-insert-drawer)

          )))

;; (after! org
;;   (setq org-tags-column 80)

;;   (map! :map evil-org-mode-map
;;         (:localleader
;;           :n "," #'org-ctrl-c-ctrl-c
;;           :n "*" #'org-ctrl-c-star
;;           :n "-" #'org-ctrl-c-minus
;;           :n "'" #'org-edit-special

;;           :n "a" #'org-agenda

;;           :n "A" #'org-attach

;;           (:desc "toggle" :prefix "t"
;;             :n "c" #'org-toggle-checkbox
;;             :n "e" #'org-toggle-pretty-entities
;;             :n "i" #'org-toggle-inline-images
;;             :n "l" #'org-toggle-link-display
;;             :n "t" #'org-todo
;;             :n "x" #'org-toggle-latex-fragment)

;;           (:desc "deadline" :prefix "d"
;;             :n "d" #'org-deadline
;;             :n "s" #'org-schedule
;;             :n "t" #'org-time-stamp
;;             :n "T" #'org-time-stamp-inactive)

;;           :n "e" #'org-export-dispatch

;;           (:desc "insert" :prefix "i"
;;             :n "d" #'org-insert-drawer
;;             :n "e" #'org-set-effort
;;             :n "f" #'org-insert-footnote
;;             :n "h" #'org-insert-heading
;;             :n "H" #'org-insert-heading-after-current
;;             :n "l" #'org-insert-link
;;             :n "p" #'org-set-property
;;             :n "s" #'org-insert-subheading
;;             :n "t" #'org-set-tags)
;;           )))

;; Testing company autocomplete
(require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)
