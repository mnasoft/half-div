;;;; half-div.lisp

(in-package #:half-div)

;;; "half-div" goes here. Hacks and glory await!

(defun boole-to-int (b) (if b 1 0))

(defun same-znak (a b)
  (if (zerop(logxor
	     (boole-to-int (minusp a))
	     (boole-to-int (minusp b))))
      t
      nil))

(defun epsylon (x &key (eps 1e-6))
  "Функция для вычисления комплексной точности."
  (+ (* (abs x) eps ) eps))

(defun h-div (a b func &key (eps 1e-6) (iters 1000))
  "Функция решения уравнения func(x)=0 методом половинного деления.
Поиск решения выполняется на отрезке [a,b].
Параметры:
a     - левая граница отрезка;
b     - правая граница отрезка;
func  - вид функциональной зависимости;
eps   - комплексная точность поиска решения;
iters - максимальное количество итераций для достижения заданной точности.
Пример использования:
(defun x2(x) (- (* x (log x)) 10000.))
(half_div 2.0 100000.0 #'x2 :iters 50)
"
  (do*
   ( (i 0 (1+ i))
     (fa (funcall func a))
     (fb (funcall func b))
     (x (/ (+ a b) 2) (/ (+ a b) 2))
     (fx (funcall func x)(funcall func x)))
   ((or
     (> i iters)
     (<= (abs(- b a))
	 (epsylon x :eps eps)))
    (values x
	    (not (> i iters))
	    (abs(- b a))
	    (epsylon x :eps eps)))
    (if (same-znak fa fx)
	(setf a x fa fx)
	(setf b x fb fx))))

(defun subst-element-by-no (lst el position)
  (substitute el (nth position lst) lst :start position))

(defun h-div-lst (a b func n p_lst &key (eps 1e-6) (iters 1000))
  "Функция решения уравнения func(X[0],X[1],...,X[n],...,X[m])=0 методом половинного деления.
Поиск решения выполняется на отрезке [a,b] для аргумента с номером n (первый аргумет имеет номер 0).
Параметры:
a     - левая граница отрезка;
b     - правая граница отрезка;
func  - вид функциональной зависимости;
n     - номер аргумента в списке аргументов функции при изменении которого на отрезке [a,b] выполняется поиск решения.
p_lst - список аргуметов функции;
eps   - комплексная точность поиска решения;
iters - максимальное количество итераций для достижения заданной точности.
Пример использования:
(defun xy2(x y) (- (* x (log x)) y))
(half_div_list 2.0 100000.0 #'xy2 0 '(t 10000.) :iters 50)
"
  (do*
   ( (i 0 (1+ i))
     (fa (apply func (subst-element-by-no p_lst a n)))
     (fb (apply func (subst-element-by-no p_lst b n)))
     (x (/ (+ a b) 2)
	(/ (+ a b) 2))
     (fx (apply func (subst-element-by-no p_lst x n))
	 (apply func (subst-element-by-no p_lst x n))))
   ((or
     (> i iters)
     (<= (abs(- b a))
	 (epsylon x :eps eps)))
    (values x
	    (not (> i iters))
	    (abs(- b a))
	    (epsylon x :eps eps)))
    (if (same-znak fa fx)
	(setf a x fa fx)
	(setf b x fb fx))))
