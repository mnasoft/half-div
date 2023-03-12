;;;; package.lisp

(defpackage :half-div
  (:use #:cl)
  (:export h-div) ;;Функция решения уравнения func(x)=0 методом половинного деления.
  (:export h-div-lst) ;;Функция решения уравнения func(X[0],X[1],...,X[n],...,X[m])=0 методом половинного деления.
  )


;;;;(declaim (optimize (space 0) (compilation-speed 0)  (speed 0) (safety 3) (debug 3)))

;;;; (declaim (optimize (compilation-speed 0) (debug 3) (safety 0) (space 0) (speed 0)))
