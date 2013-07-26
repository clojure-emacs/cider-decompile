## Installation

### Via package.el

`package.el` is the built-in package manager in Emacs 24+. On Emacs 23
you will need to get [package.el](http://bit.ly/pkg-el23) yourself if you wish to use it.

`nrepl-decompile` is available on both major `package.el` community
maintained repos -
[Marmalade](http://marmalade-repo.org/packages/nrepl) and
[MELPA](http://melpa.milkbox.net).

If you're not already using Marmalade, add this to your
`~/.emacs.d/init.el` (or equivalent) and load it with <kbd>M-x eval-buffer</kbd>.

```lisp
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
```

For MELPA the code you need to add is:

```lisp
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
```

And then you can install nREPL with the following command:

<kbd>M-x package-install [RET] nrepl-decompile [RET]</kbd>

or by adding this bit of Emacs Lisp code to your Emacs initialization file(`.emacs` or `init.el`):

```lisp
(unless (package-installed-p 'nrepl-decompile))
  (package-install 'nrepl-decompile))
```

If the installation doesn't work try refreshing the package list:

<kbd>M-x package-refresh-contents [RET]</kbd>
