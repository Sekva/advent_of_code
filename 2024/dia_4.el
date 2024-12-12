(defun re-seq-overlap (regexp string)
  (save-match-data
    (let ((pos 0)
          matches)
      (while (string-match regexp string pos)
        (push (match-string 0 string) matches)
        (setq pos (match-end 0)))
      (reverse matches))))

(defun transpor-string (texto)
  (let ((linhas-filtradas (remove "" texto)))
    (mapcar (lambda (row)
              (apply #'string row))
            (apply #'cl-mapcar #'list (mapcar #'string-to-list linhas-filtradas)))))


(defun diagonais-principais (matrix)
  (let ((rows (length matrix))
        (cols (length (car matrix)))
        diagonals)
    (dotimes (start-col cols)
      (let ((diag '()))
        (dotimes (offset rows)
          (let ((row offset)
                (col (+ start-col offset)))
            (when (and (< row rows) (< col cols))
              (push (aref (nth row matrix) col) diag))))
        (push (apply #'string (reverse diag)) diagonals)))
    (dotimes (start-row rows)
      (let ((diag '()))
        (dotimes (offset cols)
          (let ((row (+ start-row offset))
                (col offset))
            (when (and (< row rows) (< col cols))
              (push (aref (nth row matrix) col) diag))))
        (push (apply #'string (reverse diag)) diagonals)))
    (reverse diagonals)))

(defun juntar-matrix (matrix)
  (mapconcat 'identity matrix "\n"))

(defun separar-matrix (texto)
  (remove "" (s-split "\n" texto)))




(defun reverter-linha-matrix (matrix)
  (mapcar (lambda (row)
            (reverse row)) matrix))



(with-temp-buffer
  (insert-file-contents "inputs/dia_04_input_01.txt")
  (let* (
         (texto (buffer-string))
         (matrix_normal (separar-matrix texto))
         (transposto (juntar-matrix (transpor-string matrix_normal)))
         (diagonais_principais (juntar-matrix (diagonais-principais matrix_normal)))
         (diagonais_secundarias (juntar-matrix (diagonais-principais
                                                (reverter-linha-matrix (transpor-string matrix_normal))))))


    (-
    (length (append

             (re-seq "XMAS" texto)
             (re-seq "SAMX" texto)

             (re-seq "XMAS" transposto)
             (re-seq "SAMX" transposto)

             (re-seq "XMAS" diagonais_principais)
             (re-seq "SAMX" diagonais_principais)

             (re-seq "XMAS" diagonais_secundarias)
             (re-seq "SAMX" diagonais_secundarias)

             ))

    1)

    ;; diagonais_secundarias
    ))
