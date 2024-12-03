(defun re-seq (regexp string)
  (save-match-data
    (let ((pos 0)
          matches)
      (while (string-match regexp string pos)
        (push (match-string 0 string) matches)
        (setq pos (match-end 0)))
      (reverse matches))))

(defun executar_multiplicacao (texto)
  (apply '* (mapcar 'string-to-number
             (re-seq "[0-9][0-9]?[0-9]?" texto))))

(defun remover_donts (lista)
  (let* ((estado t)
         (nova_lista '()))
    (dolist (el lista)
      (if (equal "do()" el)
          (setq estado t)
        (if (equal "don't()" el)
            (setq estado nil)
          (when estado
            (push el nova_lista)))))
    (reverse nova_lista)))

;; Parte 1
(with-temp-buffer
  (insert-file-contents "inputs/dia_03_input_01.txt")
  (apply '+
         (mapcar 'executar_multiplicacao
                 (re-seq "mul([0-9][0-9]?[0-9]?,[0-9][0-9]?[0-9]?)"  (buffer-string)))))


;; Parte 2
(with-temp-buffer
  (insert-file-contents "inputs/dia_03_input_01.txt")
  (apply '+
         (mapcar 'executar_multiplicacao
                 (remover_donts
                  (re-seq
                   "\\(mul([0-9][0-9]?[0-9]?,[0-9][0-9]?[0-9]?)\\|do()\\|don't()\\)"
                   (buffer-string))))))
