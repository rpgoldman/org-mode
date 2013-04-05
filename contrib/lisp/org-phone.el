;;;---------------------------------------------------------------------------
;;; org-phone.el
;;; Add support for "phone:" links to phone numbers.
;;; Optional support for calling them with skype
;;;---------------------------------------------------------------------------

;;; Copyright (C) 2013 Free Software Foundation, Inc.

;; Author: Robert P. Goldman <rpgoldman at sift dot net>
;; Homepage: http://orgmode.org
;; Version: 0.02

;; This file is not yet part of GNU Emacs.
(require 'org)

(org-add-link-type "phone" 'org-phone-open)
;; not sure whether we need/want this yet...
;;(add-hook 'org-store-link-functions 'org-phone-store-link)

(defcustom org-phone-function 'org-phone-call
  "The Emacs function to be used to call a phone number.
By default, a simple function that uses shell-command to 
apply org-phone-call-command (qv.) to the phone number."
  :group 'org-link
  :type 'symbol)

(defcustom org-phone-call-command "skype-call"
  "The executable command to be used to call a phone number.
This should be a script that starts the call and returns: it
should not block."
  :group 'org-link
  :type 'string)


(defun org-phone-open (phone-number)
  "Phone the number PHONE-NUMBER.
PHONE-NUMBER should be a string for a PSTN phone number."
  (funcall org-phone-function phone-number))

(defun org-phone-call (phone-number)
  (shell-command (format "%s %s"
			 org-phone-call-command
			 phone-number)))
  
(defun trim-phone-number (phone-number)
  "Remove whitespace, parentheses, and embedded (0) from a telephone
 number"
  (mapconcat 'identity
	     (split-string
	      (mapconcat 'identity
			 (split-string phonenumber "(0)") "")
	      "[()/ -]") ""))
  

;; (defun org-phone-store-link ()
;;   "Store a link to a phone number."
;;     ;; This is a man page, we do make this link
;;     (let* ((page (org-man-get-page-name))
;; 	   (link (concat "man:" page))
;; 	   (description (format "Manpage for %s" page)))
;;       (org-store-link-props
;;        :type "man"
;;        :link link
;;        :description description))))


(provide 'org-phone)
