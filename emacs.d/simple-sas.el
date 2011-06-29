
(define-generic-mode 'simple-sas-mode
  '(("/*" . "*/")) 
  '(
	"and" 
	"as"
	"begin" 
	"by" 
	"call" 
	"data" 
	"delete" 
	"descending"
	"else" 
	"end" 
	"format"
	"from"
	"if"
	"in"
	"libname"
	"or" 
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
	"insert"

	"create table"
	"drop table"
	"group by"
	"insert into"

	)
  '( 
   ("\\((keep [^)]*)\\)" 1 'font-lock-preprocessor-face)
   ("\\((drop [^)]*)\\)" 1 'font-lock-preprocessor-face)
   ("\\((rename [^)]*)\\)" 1 'font-lock-preprocessor-face)
   ("\\(\"[^\"]*\"\\)" 1 'font-lock-string-face)  ; quoted strings -- "hides" macro variables, tho
   ("\\(\'[^\']*\'\\)" 1 'font-lock-string-face)  ; quoted strings
   ("\\(&[[:alnum:]_]*\\.\\)" 1 'font-lock-variable-name-face)  ; Macro variable &sdlkfsjdl.
   ("\\(%[[:alnum:]]*[^[:alnum:]]\\)" 1 'font-lock-function-name-face)  ; Macro keywords %stuff 
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
					 )))
  "Major mode for very simple SAS highlighting and indenting.")
