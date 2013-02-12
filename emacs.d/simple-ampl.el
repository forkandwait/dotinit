
(define-generic-mode 'simple-ampl-mode
  '(  ("#" ) ("/*" . "*/")  ) 						; 
  '(
	"and" 
	"arc"
	"binary"
	"check"
	"data"
	"default"
	"display"
	"else"
	"fix"
	"for"
	"if"
	"in"
	"integer"
	"let"
	"maximize"
	"minimize"
	"node"
	"not"
	"option"
	"or"
	"param"
	"prod"
	"round"
	"s.t."
	"solve"
	"subject to"
	"sum"
	"symbolic"
	"then"
	"var"
	"set"
	)
  '( 									;font-lock-list
	;;("\\(\\*[^;\\*/]*;\\)" 0 'font-lock-comment-face t) ;
	
	); 
  
  
  '("\\.mod\\'")
  (list (lambda () (progn 
					 ;; indent as nicely as possible
					 (defun sasret ()
					   (interactive)
					   (cond 
						;; empty line
						((and (looking-back "^") (looking-at "$")) ; empty line
						 (progn (newline)))
						;; front of line
						((and (looking-back "^") (looking-at "$")) ; empty line
						 (progn (newline)))
						;; in middle of leading spaces
						((and (looking-back "^[[:blank:]]*") (looking-at "[[:blank:]]+[[:word:][:punct:]]")) 
						 (progn (skip-chars-forward "[:space:]")
								(newline-indent-relative)))
						;; otherwise
						('t (progn (newline-indent-relative)))))

					 (local-set-key (kbd "<return>") 'sasret)
					 (setq indent-tabs-mode nil)
					 (local-set-key (kbd "<tab>") 'tab-to-tab-stop) 
					 (local-set-key (kbd "C-<tab>") 'indent-relative-maybe) 
					 (modify-syntax-entry ?_ "w")         ; make  '_'  a word-delimiter for dynamic abbr
					 (setq font-lock-defaults '(generic-font-lock-keywords nil t))

					 )))
  "Major mode for very simple AMPL highlighting and indenting.")
