;;; nrepl.el --- decompilation extension for nrepl.el

;; Copyright © 2013 Dmitry Bushenko
;;
;; Author: Dmitry Bushenko
;; URL: http://www.github.com/clojure-emacs/nrepl-decompile
;; Version: 0.0.1
;; Keywords: languages, clojure, nrepl
;; Package-Requires: ((nrepl "0.1.7") (javap-mode "9"))

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Provides an `nrepl-decompile' command.

;;; Installation:

;; Available as a package in marmalade-repo.org and melpa.milkbox.net.

;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/"))
;;
;; or
;;
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;
;; M-x package-install nrepl-decompile

;;; Usage:

;; M-x nrepl-decompile

;;; Code:

(require 'nrepl)
(require 'javap-mode)

(defun nrepl-decompile (fn-name)
  "Decompiles specified function into the java bytecode.
Opens buffer *decompiled* with the result of decompilation,
enables javap-mode on it.  Input: FN-NAME in format 'my-namespace$my-function'.
All dashes will be replaced with underscores, the dollar symbol will be
escaped."
  (let* ((buf-name "*decompiled*")
   (class-name
    (replace-regexp-in-string "-" "_"
      (replace-regexp-in-string "\\$" "\\\\$" fn-name)))
   (cmd
    (concat "javap -constants -v -c -classpath `lein classpath` "
      class-name))
   (decompiled (shell-command-to-string cmd)))
    (with-current-buffer (get-buffer-create buf-name)
      (point-min)
      (insert decompiled)
      (javap-mode))
    (display-buffer buf-name)))

(defun nrepl-decompile-func (fn-name)
  "Asks for the func name (FN-NAME) in the current namespace.and decompiles."
  (interactive "sFunction: ")
  (nrepl-decompile (concat (nrepl-current-ns) "$" fn-name)))

(defun nrepl-decompile-ns-func (fn-name)
  "Asks for the func name (FN-NAME) in a specific namespace and decompiles it.
The FN-NAME should be prefixed with the namespace."
  (interactive "sNamespace/function:  ")
  (nrepl-decompile (concat (replace-regexp-in-string "\\\/" "$" fn-name))))

(provide 'nrepl-decompile)
;;; nrepl-decompile.el ends here
