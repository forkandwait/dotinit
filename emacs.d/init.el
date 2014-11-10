; -*-buffer-read-only:'t-*-
;; set current working directory a_ somewhere reasonable -- home.  on
;; windows, set this in the short cut
(setq default-directory "~")
(cd "~")


;; weirdness with "servers"
;(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; MS Windows specific   
(if (eq system-type 'windows-nt)
	(progn (message "Running windows -- ack!")
		   (setq tcl-application "C:/Tcl/bin/tclsh") ;hackish, but whatever
		   (tool-bar-mode 0)
		   (setq temporary-file-directory "C:\\Temp")
		   (push "c:\\Git\\bin" exec-path)
		   (setenv "PATH" (concat  "c:\\Git\\bin;"
								  (getenv "PATH")))))

;; Location on desktop
(setq default-frame-alist
      '((top . 120) (left . 65)
        (width . 80) (height . 30)))

;; package paths
(add-to-list 'load-path "~/.init/emacs.d/bookmark-plus-master")
(add-to-list 'load-path "~/.init/emacs.d/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Overall stuff -- editing, saving etc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; julia mode
;; (require 'julia-mode)

;; stop trying to handle version control
(setq vc-handled-backends ())


;; Truncate lines (working with code all the time)
(setq truncate-lines 1)


;; bookmark+ is cool
(require  'bookmark+ )
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")
(global-set-key [f2] 'bmkp-next-bookmark-this-file/buffer-repeat)   
(global-set-key [(control f2)] 'bookmark-set)   
(global-set-key [(shift control f2)] 'bmkp-toggle-autonamed-bookmark-set/delete)   

;; cua and ido modes -- I am now a believer
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
;;(ido-mode t)
;;(ido-everywhere)
;;(setq cua-enable-cua-keys nil)

;; align command
(defun align-repeat (start end regexp)
  "Repeat alignment with respect to 
     the given regular expression."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end 
		(concat "\\(\\s-*\\)" regexp) 1 1 t))

;; various nifty things
(load-theme 'wombat)
(display-time)
(auto-compression-mode t)     ;; Handle .gz files
(column-number-mode 1)  
(fset 'yes-or-no-p 'y-or-n-p) ;; Changes all yes/no questions abc  to y/n type
(line-number-mode 1)
(menu-bar-mode 0)
(modify-syntax-entry ?_ "w")  ;; make '_' a regular word symbol
(savehist-mode 1)
(setq auto-save-list-file-prefix nil)
(setq make-backup-files nil)
(setq show-paren-style 'expression)
(setq inhibit-splash-screen t)
(setq vc-follow-symlinks t)
(show-paren-mode 1)
(set-face-foreground 'font-lock-comment-face "firebrick")

;; surround with parens and friends
(global-set-key (kbd "M-[") 'insert-pair)
(global-set-key (kbd "M-\"") 'insert-pair)
(global-set-key (kbd "M-\'") 'insert-pair)

;; stupid buffers have been modified
(defun my-kill-emacs ()
  "save some buffers, then exit unconditionally"
  (interactive)
  (save-some-buffers nil t)
  (kill-emacs))

;; scroll one line at a time (less "jumpy" than defaults) 
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time 

;; bigger font
(set-default-font "-adobe-courier-medium-r-normal--16-180-75-75-m-110-iso8859-1")

;; newline craziness
(setq-default require-final-newline 'ask)
(setq-default next-line-add-newlines nil)

;; dabbrev customization
(setq-default dabbrev-abbrev-skip-leading-regexp "[~!@#$%^&*()+=';`\\{}/.,\"]") ;; can complete %WS_MATCH etc
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
(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq-default tab-width 4)
(setq-default default-tab-width 4)
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48
 								52 56 60 64 68 72 76 80 84 88 92
								96 100 104 108 112 116 120))


;; zap up to char default
(autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR.
  
  \(fn arg char)"
    'interactive)
(global-set-key "\M-z" 'zap-up-to-char)

;; Load hide-region.el 
(load-file "~/.init/emacs.d/hide-region.el")
(global-set-key (kbd "C-c h") 'hide-region-hide)
(global-set-key (kbd "C-c H") 'hide-region-unhide)

;; Load simple-sas.el
(load-file "~/.init/emacs.d/simple-sas.el")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Program/ mode specific
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load simple-ampl.el
;; (load-file "~/.init/emacs.d/simple-ampl.el")

;; mod, dat, run are all AMPL, but force to text for now
;; (setq auto-mode-alist
;;       (cons '("\\.mod$" . text-mode) auto-mode-alist))
;; (setq auto-mode-alist
;;       (cons '("\\.dat$" . text-mode) auto-mode-alist))
;; (setq auto-mode-alist
;;       (cons '("\\.run$" . text-mode) auto-mode-alist))

;; octave customizations
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(setq-default octave-block-offset 4)
(add-hook 'octave-mode-hook
		  '(lambda ()
			 (progn
			   (setq indent-tabs-mode nil))))

;; tcl mode customization
(add-hook 'tcl-mode-hook
		  '(lambda ()
			 (progn
			   (setq indent-tabs-mode nil)
				   )))
;(add-hook 'inferior-tcl-mode-hook
;          (lambda ()

;; text mode customizations
(add-hook 'text-mode-hook
          '(lambda ()	     
             (auto-fill-mode 0)
             (setq fill-column 80) 
	     
			 (local-set-key (kbd "TAB") 'tab-to-tab-stop)
			 (setq tab-width 4)
			 (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
									 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)) 
			 
             (modify-syntax-entry ?_ "w")       ; now '_' is not considered a word-delimiter
             (modify-syntax-entry ?- "w")       ; now '-' is not considered a word-delimiter 
			 (setq require-final-newline 'ask)
			 (setq next-line-add-newlines nil) 
			 (define-key text-mode-map (kbd "TAB") 'self-insert-command)
             ))

(add-hook 'sql-mode-hook
		  '(lambda ()
			 (progn
			   (setq-default buffer-read-only 't) 
			   (setq-default tab-width 4)
			   (setq comment-start "/* ")
			   (setq comment-end " */")
			   (setq tab-stop-list '(4 9))
			   (set-face-foreground 'font-lock-string-face "red")
			   (setq indent-tabs-mode nil)
			   (setq indent-line-function 'tab-to-tab-stop) 
			   (modify-syntax-entry ?_ "w")       ; now '_' is not considered a word-delimiter
			   (modify-syntax-entry ?- "w")       ; now '-' is not considered a word-delimiter 
			   )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Longwinded definitions and macros, usually accompanied by key
;; bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; copy the region defined between registers 1 and 2, returns to starting location
(fset 'cpr
   [?\C-x ?r ?  ?3 ?\C-x ?r ?j ?1 ?\C-  ?\C-x ?r ?j ?2 ?\M-w ?\C-x ?r ?j ?3])
(global-set-key (kbd "C-c c") 'cpr)

;; newline and indent-relative
(defun newline-indent-relative ()
  "blah"
  (interactive)
  (progn 
	(newline)
	(indent-relative-maybe))) 
(global-set-key (kbd "C-j") 'newline-indent-relative) 

;; random number
(defun insert-random-number ()
  "Insert a 4 digits random number."
  (interactive)
  (insert
   (number-to-string (random 9999))))

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
  "Insert string for the current time formatted like '2:34 PM'"
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%Y-%m-%d WS(OFM): ")))
(global-set-key (kbd "M-n") 'note)

;; Insert CREATE TABLE XXX AS 
(defun create-table (T)
  "Insert string for sql CREATE TABLE"
  (interactive "sTable Name? ")                 ; permit invocation in minibuffer
  (insert (format "CREATE TABLE %s AS " T)) 
  )
(global-set-key (kbd "C-c t") 'create-table)

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
"/*** -*-mode:simple-sas;buffer-read-only:'t-*- *****************************

    DESCRIPTION:  

    PROGRAMMERS:  webb.sprague@ofm.wa.gov

    DATE STARTED:  %Y-%m-%d

    PARAMETERS:  

    NOTES:  
    
*********************************************************/
"))
  (previous-line 9)
  (forward-char 18)
)

;; Insert a "section break" comment for octave
(defun comm () (interactive)
  (insert(format-time-string
"############################################################
##    
############################################################"))
  (previous-line 2)
  (forward-char 4)
)
