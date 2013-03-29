;;;---------------------------------------------------------------------------
;;; org-phone.el
;;; Add support for "phone:" links to phone numbers.
;;; Optional support for calling them with skype
;;;---------------------------------------------------------------------------

;;; Copyright (C) 2013 Free Software Foundation, Inc.

;; Author: Robert P. Goldman <rpgoldman at sift dot net>
;; Homepage: http://orgmode.org
;; Version: 0.01

;; This file is not yet part of GNU Emacs.
(require 'org)

(org-add-link-type "phone" 'org-phone-open)
;; not sure whether we need/want this yet...
;;(add-hook 'org-store-link-functions 'org-phone-store-link)

(defcustom org-phone-function 'skype-call
  "The Emacs function to be used to call a phone number."
  :group 'org-link
  :type 'symbol)

(defcustom org-skype-command "skype-call"
  "The executable command to be used to call a phone number.
This should be a script that starts the call and returns: it
should not block."
  :group 'org-link
  :type 'string)


(defun org-phone-open (phone-number)
  "Phone the number PHONE-NUMBER.
PHONE-NUMBER should be a string for a PSTN phone number."
  (funcall org-phone-function phone-number))

(defun skype-call (phone-number)
  (shell-command (format "%s %s"
			 org-skype-command
			 phone-number)))
  
  

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
