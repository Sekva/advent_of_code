(defun extrair_n_esima_coluna (filename n)
  (with-temp-buffer
    (insert-file-contents filename)
    (let (result)
      (while (not (eobp))
        (let ((line (thing-at-point 'line t)))
          (when line
            (let ((columns (split-string line)))
              (when (>= (length columns) n)
                (let ((nth-column (nth (1- n) columns)))
                  (setq result (append result (list (string-to-number nth-column)))))))))
        (forward-line 1))
      result)))

(defun count-occurrences (element list)
  (let ((count 0))
    (dolist (item list count)
      (when (equal item element)
        (setq count (1+ count))))))

(defun pegar_score (el lista)
  (* el (count-occurrences el lista)))

;; Parte 1
(apply '+
       (mapcar 'abs
               (seq-mapn '-
                         (sort (extrair_n_esima_coluna "inputs/1_1.txt" 1) 'math-lessp)
                         (sort (extrair_n_esima_coluna "inputs/1_1.txt" 2) 'math-lessp))))

;; Parte 2
(let* ((primeira_lista (extrair_n_esima_coluna "inputs/1_1.txt" 1))
       (segunda_lista (extrair_n_esima_coluna "inputs/1_1.txt" 2)))
  (apply '+(mapcar (lambda (el) (funcall 'pegar_score el segunda_lista)) primeira_lista)))
