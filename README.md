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

## Usage

First you have to install javap-mode because it will be used to display JVM-bytecode.

Next. Since nrepl-decompile depends on nrepl, it has to be installed and running. Start nrepl session like this:

<kbd>M-x nrepl-jack-in [RET]</kbd>

Let's say, we've got the following namespace in the Clojure project: myns.core. Compile it, pressing in its buffer:

<kbd>C-c C-k</kbd>

Switch to this namespace in the nrepl buffer.

```lisp
(in-ns 'myns.core)
```

Now you may decompile any function in the current namespace using command "nrepl-decompile-func". For instance, if you have function myns.core/main, then you may decompile it like this:

<kbd>M-x nrepl-decompile-func [RET] main [RET]</kbd>

If you want to decompile a function from the other namespaces, you may use command "nrepl-decompile-ns-func". For example, decompiling function myotherns.core/other-main would look like this:

<kbd>M-x nrepl-decompile-ns-func [RET] myotherns.core/other-main [RET]</kbd>

After the command was invoked, the buffer *decompiled* apears showing the bytecode of the function.