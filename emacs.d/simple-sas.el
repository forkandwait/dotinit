
(define-generic-mode 'simple-sas-mode
  '( ("/*" . "*/")  )                    ; comment delimiters ("* " . ";")
  '(										; keywords
    "abort"
    "and"
	"array"
    "as"
    "begin"
    "by"
    "call"
    "case"
    "data"
    "delete"
    "descending"
    "do"
    "drop"
    "else"
    "end"
    "filename"
    "format"
    "from"
    "goto"
    "having"
    "if"
    "in"
    "insert"
    "infile"
    "informat"
    "input"
    "join"
    "keep"
    "label"
	"length"
    "libname"
    "merge"
    "nodupkeys"
    "noduplicates"
    "not"
    "on"
    "or"
    "option"
	"options"
	"otherwise"
    "output"
    "proc"
    "put"
    "quit"
    "retain"
    "rename"
    "run"
    "select"
    "sql"
    "set"
    "then"
    "transpose"
    "update"
    "when"
    "where"
    "while"

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
  '(                                    ;font-lock-list
   ;;("\\(\\*[^;\\*/]*;\\)" 0 'font-lock-comment-face t) ; silly comments
   ("\\((keep [^)]*)\\)" 0 'font-lock-preprocessor-face)
   ("\\((drop [^)]*)\\)" 0 'font-lock-preprocessor-face)
   ("\\((rename [^)]*)\\)" 0 'font-lock-preprocessor-face)
   ("\\(%[[:alnum:]_]*[^[:alnum:]]\\)" 0 'font-lock-function-name-face)  ; Macro keywords %stuff
   ;; ("\\(\"[^\"]*[\"\']\\)" 0 'font-lock-string-face)  ; quoted strings -- "hides" macro variables, tho
   ;; ("\\(\'[^\']*[\']\\)" 0 'font-lock-string-face)  ; quoted strings
   ;; ("\\(\\(\'[^\']*\'\\)\\|\\(\"[^\"]*\"\\)\\)" 0 'font-lock-string-face)
   ("\\(&[[:alnum:]_]*\\.\\)" 0 'font-lock-function-name-face prepend)  ; Macro variable &sdlkfsjdl.

   )  ;


  '("\\.sas\\'")
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

                     (copy-face 'bold 'sas-keyword-face)
                     (set-face-foreground 'sas-keyword-face "LightSlateBlue")
                     (setq font-lock-keyword-face 'sas-keyword-face)

                     ;(copy-face 'bold 'sas-constant-face)
                     ;(set-face-foreground 'sas-constant-face "Green")
                     ;(setq font-lock-constant-face 'sas-constant-face)

                     (copy-face 'bold 'sas-variable-name-face)
                     (set-face-foreground 'sas-variable-name-face "DarkCyan")
                     (setq font-lock-variable-name-face 'sas-variable-name-face)

                     (setq font-lock-defaults '(generic-font-lock-keywords nil t))

					 (setq-default buffer-read-only 't) 

                     )))
  "Major mode for very simple SAS highlighting and indenting.")
