
(define-generic-mode 'simple-sas-mode
  '( ("/*" . "*/") ) 						; comment delimiters ("* " . ";")
  '(													; keywords
	"abort"
	
	"and" 
	"as"
	"begin" 
	"by" 
	"call" 
	"case"
	"data" 
	"delete" 
	"descending"
	"do"
	"else" 
	"end" 
	"format"
	"from"
	"having"
	"if"
	"in"
	"insert"
	"infile"
	"input"
	"join"
	"label"
	"libname"
	"nodupkeys"
	"noduplicates"
	"not"
	"on"
	"or" 
	"option"
	"output" 
	"proc" 
	"quit" 
	"retain"
	"run"
	"select"
	"sql"
	"set" 
	"then" 
	"transpose"
	"update"
	"when"
	"where"

	"alter table"
	"create table"
	"drop table"
	"group by"
	"insert into"
	"left outer join"
	"full outer join"
	"order by"
	"rename to"
	)
  '( 									;font-lock-list
   ("\\(\\*[^;\\*/]*;\\)" 0 'font-lock-comment-face t) ; silly comments
   ("\\((keep [^)]*)\\)" 0 'font-lock-preprocessor-face)
   ("\\((drop [^)]*)\\)" 0 'font-lock-preprocessor-face)
   ("\\((rename [^)]*)\\)" 0 'font-lock-preprocessor-face)
   ("\\(%[[:alnum:]_]*[^[:alnum:]]\\)" 0 'font-lock-function-name-face)  ; Macro keywords %stuff 
   ("\\(\"[^\"]*\"\\)" 0 'font-lock-string-face)  ; quoted strings -- "hides" macro variables, tho
   ("\\(\'[^\']*\'\\)" 0 'font-lock-string-face)  ; quoted strings
   ("\\(&[[:alnum:]_]*\\.\\)" 0 'font-lock-function-name-face prepend)  ; Macro variable &sdlkfsjdl.

   ); 
										
										
  '("\\.sas\\'")
  (list (lambda () (progn 
					 (local-set-key (kbd "<return>") 'newline-indent-relative)
					 (local-set-key (kbd "C-<return>") 'newline)
					 (local-set-key (kbd "<tab>") 'tab-to-tab-stop) 
					 (local-set-key (kbd "C-<tab>") 'indent-relative-maybe) 
					 (modify-syntax-entry ?_ "w")         ; make  '_'  a word-delimiter for dynamic abbr

					 (copy-face 'bold 'sas-keyword-face)
					 (set-face-foreground 'sas-keyword-face "LightSlateBlue")
					 (setq font-lock-keyword-face 'sas-keyword-face)

					 (copy-face 'bold 'sas-constant-face) 
					 (set-face-foreground 'sas-constant-face "Green")
					 (setq font-lock-constant-face 'sas-constant-face)

					 (copy-face 'bold 'sas-variable-name-face) 
					 (set-face-foreground 'sas-variable-name-face "DarkCyan")
					 (setq font-lock-variable-name-face 'sas-variable-name-face)

					 (setq font-lock-defaults '(generic-font-lock-keywords nil t))

					 )))
  "Major mode for very simple SAS highlighting and indenting.")

;; indent nicely -- still working
(defun sasret ()
  (interactive)
  (progn 
	(skip-chars-forward "[:space:]")
	(newline-indent-relative)))
