(defpackage toot-fortune
  (:use #:cl #:tooter)
  (:export #:periodic-toot))

(defvar fortune-path "/usr/games/fortune")

(defun get-fortune ()
  (let ((s (make-string-output-stream)))
    (uiop:run-program
     (list fortune-path (values-list (uiop:command-line-arguments)))
     :output s)
    (get-output-stream-string s)))

(defvar *client* (make-instance 'tooter:client
				:base "https://botsin.space"
				:name "Fortune (Anarchism)"))
;; (tooter:authorize *client*)
;; (tooter:authorize *client* "...")

(tooter:account *client*)

(defun periodic-toot ()
  (tooter:make-status *client* (get-fortune))
  (sleep (/ (* 3600 24) 4))
  (periodic-toot))
