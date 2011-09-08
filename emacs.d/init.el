
;; set current working directory a_ somewhere reasonable -- home.  on
;; windows, set this in the short cut
(setq default-directory "~")
(cd "~")
(server-start)

;; MS Windows specific   
(if (eq system-type 'windows-nt)
	(progn (message "Running windows -- ack!")
		   (tool-bar-mode 0)
		   (setq temporary-file-directory "C:\\Temp")
		   (push "C:/GetGnuWin32/gnuwin32/bin" exec-path)
		   (setenv "PATH" (concat "C:\\GetGnuWin32\\gnuwin32\\bin;"
								  (getenv "PATH")))))

(setq default-frame-alist
      '((top . 275) (left . 175)
        (width . 115) (height . 40)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Overall stuff -- editing, saving etc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; various nifty things
(auto-compression-mode t)     ;; Handle .gz files
(column-number-mode 1)  
(fset 'yes-or-no-p 'y-or-n-p) ;; Changes all yes/no questions abc  to y/n type
(line-number-mode 1)
(menu-bar-mode 0)
(modify-syntax-entry ?_ "w")  ;; make '_' a regular word symbol
(savehist-mode 1)
(setq auto-save-list-file-prefix nil)
(setq delete-selection-mode 1) 
(setq make-backup-files nil)
(setq show-paren-style 'expression)
(setq inhibit-splash-screen t)
(setq vc-follow-symlinks t)
(show-paren-mode 1)
(set-face-foreground 'font-lock-comment-face "firebrick")

;; bigger font
(set-default-font "-adobe-courier-medium-r-normal--16-180-75-75-m-110-iso8859-1")

;; newline craziness
(setq require-final-newline t)

;; dabbrev customization
(setq-default dabbrev-abbrev-skip-leading-regexp "[~!@#$%^&*()+=';`\\{}/.,\"]") ;; so we can dynamically complete %WS_MATCH etc
(setq-default dabbrev-abbrev-char-regexp "[[:alnum:]_]")

;; fontification stuff
(autoload 'font-lock-mode "font-lock")
(autoload 'turn-on-font-lock "font-lock")
(font-lock-mode t)

;;; Tell emacs to keep the point when we scroll back
(setq scroll-preserve-screen-position t)
(setq scroll-step 1)

;; allow up/down case
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
	
;; tabs - blech!
(setq tab-width 4)
(setq-default tab-width 4)
(setq-default default-tab-width 4)
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48
 								52 56 60 64 68 72 76 80 84 88 92
 								96 100 104 108 112 116 120))
;; (define-key text-mode-map (kbd "TAB") 'self-insert-command);

;; emulate search histor http://www.emacswiki.org/emacs/MinibufferHistory
(define-key minibuffer-local-map (kbd "M-p") 'previous-complete-history-element)
(define-key minibuffer-local-map (kbd "M-n") 'next-complete-history-element)
;;(define-key minibuffer-local-map (kbd "<up>") 'previous-complete-history-element)
;;(define-key minibuffer-local-map (kbd "<down>") 'next-complete-history-element)

;; Load fastnav thing for good zapping
(load-file "~/.init/emacs.d/fastnav.el")
(global-set-key (kbd "C-c z") 'zap-up-to-char-forward)
(global-set-key (kbd "C-c Z") 'zap-up-to-char-backward)

;; Load hide-region.el 
(load-file "~/.init/emacs.d/hide-region.el")
(global-set-key (kbd "C-c h") 'hide-region-hide)
(global-set-key (kbd "C-c H") 'hide-region-unhide)

;; Load simple-sas.el
(load-file "~/.init/emacs.d/simple-sas.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Program/ mode specific
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; octave customizations
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(setq-default octave-block-offset 4)

;; text mode customizations
(add-hook 'text-mode-hook
          '(lambda ()
			 (local-set-key (kbd "TAB") 'tab-to-tab-stop)
             (auto-fill-mode 0)
             (setq fill-column 80) 

             (setq tab-width 4)
             (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                                     64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)) 

             (modify-syntax-entry ?_ "w")       ; now '_' is not considered a word-delimiter
             (modify-syntax-entry ?- "w")       ; now '-' is not considered a word-delimiter 

			 (define-key text-mode-map (kbd "TAB") 'tab-to-tab-stop)

			 ;(local-set-key (kbd "<return>") 'newline-indent-relative)
			 ;(local-set-key (kbd "C-<return>") 'newline) 
			 ;(local-set-key (kbd "<tab>") 'tab-to-tab-stop)
			 ;(local-set-key (kbd "C-<tab>") 'indent-relative)
             ))

(add-hook 'sql-mode-hook
		  '(lambda ()
			 (progn
			   (setq-default tab-width 4)
			   (local-set-key (kbd "TAB") 'tab-to-tab-stop)
			   )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Longwinded definitions and macros, usually accompanied by key
;; bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; shooting for backward search through history on minibuffer
(mapc (lambda (map)
        (define-key map [(meta p)] 'previous-complete-history-element)
        (define-key map [(meta n)] 'next-complete-history-element))
      (list minibuffer-local-completion-map
	    minibuffer-local-isearch-map
	    minibuffer-local-map
	    minibuffer-local-must-match-map
	    minibuffer-local-ns-map))


;; Sorts all the words on a line.  Would be better in a region, maybe.
(defun sort-words-in-lines (start end)
  (interactive "r")
  (goto-char start)
  (beginning-of-line)
  (while (< (setq start (point)) end)
    (let ((words (sort (split-string (buffer-substring start (line-end-position)))
                       (function string-lessp))))
      (delete-region start (line-end-position))
      (dolist (word words ) (insert word " "))
      (delete-trailing-whitespace))
    (beginning-of-line) (forward-line 1))) 


;; wrap with text -- comment, arbitrary
(defun wrap-comment ()
  (interactive)
  (let ((beg (region-beginning))
		(end (region-end)))
	(goto-char beg)
	(insert "/*")
	(goto-char (+ 2 end))
	(insert "*/")))
(global-set-key (kbd "C-c c") 'wrap-comment)

(defun insert-or-wrap (string)
  (interactive "*Mtext to wrap with")
  (if (not (use-region-p))
      (insert string)
    (let ((beg (region-beginning))
          (end (region-end)))
	  (goto-char beg)
	  (insert string)
	  (goto-char (+ (length string) end))
	  (insert string))))
(global-set-key (kbd "C-c w") 'insert-or-wrap)

;; switch between non-system buffers
;; http://xahlee.org/emacs/elisp_examples.html
(defun next-user-buffer ()
  "Switch to the next user buffer in cyclic order.\n User buffers are those not starting with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-user-buffer ()
  "Switch to the previous user buffer in cyclic order.\n User buffers are those not starting with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(global-set-key (kbd "C-<prior>") 'previous-user-buffer) ; Ctrl+PageDown
(global-set-key (kbd "C-<next>") 'next-user-buffer) ; Ctrl+PageUp
(global-set-key (kbd "C-c p") 'previous-user-buffer) ; 
(global-set-key (kbd "C-c n") 'next-user-buffer) ; 

;; newline and indent-relative
(defun newline-indent-relative ()
  "blah"
  (interactive)
  (progn 
	(newline)
	(indent-relative-maybe))) 
(global-set-key (kbd "C-j") 'newline-indent-relative) 

;; Rigidly indent. C-c 4 indents in, C-c - 4 outdents the same.  Keeps
;; working on the same region if repeated (highlight disappears)
(fset 'ind4
   [?\C-u ?4 ?\C-x tab])
(global-set-key (kbd "C-c 4") 'ind4)

(fset 'ind2
   [?\C-u ?2 ?\C-x tab])
(global-set-key (kbd "C-c 2") 'ind2)

(fset 'outd4
   [?\C-u ?- ?4 ?\C-x tab])
(global-set-key (kbd "C-c - 4") 'outd4)

;; Search to the front of a word...
(defun fw()
  "move to the front of the next word"
  (interactive)
  (forward-char)
  (re-search-forward "[^[:alnum:]-/]\\b[[:alnum:]]")
  (backward-char))
(global-set-key (kbd "C-M-f") 'fw) 

;; Insert dates, times, notes
(defun note ()
  "Insert string for the current time formatted like '2:34 PM'."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%Y-%m-%d WS: ")))
(global-set-key (kbd "M-n") 'note)

;; copy the buffer to the clipboard.  Recorded macro.  No idea what
;; the weird kmacro-exec... thing does.
(setq last-kbd-macro
      [?\M-< ?\C-  ?\M-> ?\M-w ?\C-u ?\C-  ?\C-u ?\C- ])
(fset 'pa
      (lambda (&optional arg)
    "Keyboard macro." (interactive "p") 
    (kmacro-exec-ring-item 
     (quote ([134217788 67108896 134217790 134217847 21 67108896 21 67108896] 0 "%d")) arg)))

;; Insert a header regarding code 
(defun bp () (interactive)
  (insert(format-time-string
"/*** -*-mode:simple-sas-*- **************************************************************
    
    PROGRAM/MACRO: 
    
    DESCRIPTION:  
    
    PROGRAMMERS:  webb.sprague@ofm.wa.gov    
    
    DATE STARTED: %Y-%m-%d

    INPUT (DATASETS, NAMES, ETC): 

    OUTPUT  (DATASETS, NAMES, ETC): 
    
    NOTES:
    
**********************************************************************************/
"))
  (previous-line 9)
  (forward-char 18)
)

;; Insert a "section break" comment
(defun com () (interactive)
  (insert(format-time-string
"/*********************************************************************************
    
**********************************************************************************/"))
  (previous-line 2)
  (forward-char 4)
)


;; Insert a MAIN delimiter thing
(defun mn () (interactive)
  (insert(format-time-string
"/**** MAIN **********************************************************************/"))
  (newline))
