;;;; package.lisp

(defpackage :half-div
  (:use #:cl)
  (:export h-div) ;;Функция решения уравнения func(x)=0 методом половинного деления.
  (:export h-div-lst) ;;Функция решения уравнения func(X[0],X[1],...,X[n],...,X[m])=0 методом половинного деления.
  )

(in-package :half-div)
