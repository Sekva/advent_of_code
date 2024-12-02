f(defun extrair_linhas_como_lista (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (let (result)
      (while (not (eobp))
        (let ((line (thing-at-point 'line t)))
          (when line
            (let ((columns (split-string line)))
              (setq result (append result (list (mapcar 'string-to-number columns)))))))
        (forward-line 1))
      result)))

(defun maior_diferenca (lista)
  (let ((max-diff 0))
    (while (and lista (cdr lista))
      (let ((diff (abs (- (car lista) (cadr lista)))))
        (when (> diff max-diff)
          (setq max-diff diff)))
      (setq lista (cdr lista)))
    max-diff))

(defun eh_incremental (relatorio)
  (equal relatorio (-sort 'math-lessp relatorio)))

(defun eh_decremental (relatorio)
  (equal relatorio (-sort (lambda (a b) (not (math-lessp a b))) relatorio)))

(defun tem_duplas_iguais (relatorio)
  (let ((tem_dupla nil))
    (while (and relatorio (cdr relatorio))
      (setq tem_dupla (or tem_dupla (equal (car relatorio) (cadr relatorio))))
      (setq relatorio (cdr relatorio)))
    tem_dupla))

(defun eh_monotonico (relatorio)
  (and
   (or (eh_incremental relatorio)
       (eh_decremental relatorio))
   (not (tem_duplas_iguais relatorio))))

(defun dentro_do_invervalo (relatorio)
  (let* ((diferenca (maior_diferenca relatorio)))
    (and (>= diferenca 1) (<= diferenca 3))))


(defun pop_nesimo (n lista)
  (let ((nova_lista (copy-sequence lista)))
    (cadr (list (pop (nthcdr n nova_lista)) nova_lista))))

;; Parte 1
(defun seguro_parte1 (relatorio)
  (and (eh_monotonico relatorio)
       (dentro_do_invervalo relatorio)))
(length (-filter 'seguro_parte1 (extrair_linhas_como_lista "inputs/dia_02_input_01.txt")))

;; Parte 2
(defun seguro_parte2 (relatorio)
  (let ((seguro (seguro_parte1 relatorio)))
    (dotimes (i (length relatorio))
      (setq seguro (or seguro (seguro_parte1 (pop_nesimo i relatorio)))))
    seguro))
(length (-filter 'seguro_parte2 (extrair_linhas_como_lista "inputs/dia_02_input_01.txt")))
