## Installation

### Via package.el

`package.el` is the built-in package manager in Emacs 24+. On Emacs 23
you will need to get [package.el](http://bit.ly/pkg-el23) yourself if you wish to use it.

`cider-decompile` is available on both major `package.el` community
maintained repos -
[Marmalade](http://marmalade-repo.org/packages/cider) and
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

And then you can install CIDER with the following command:

<kbd>M-x package-install [RET] cider-decompile [RET]</kbd>

or by adding this bit of Emacs Lisp code to your Emacs initialization file(`.emacs` or `init.el`):

```lisp
(unless (package-installed-p 'cider-decompile))
  (package-install 'cider-decompile))
```

If the installation doesn't work try refreshing the package list:

<kbd>M-x package-refresh-contents [RET]</kbd>

## Usage

First you have to install javap-mode because it will be used to display JVM-bytecode. You also need to compile your clojure files to bytecode by running <kbd>lein compile</kbd> on a command prompt inside your project directory.

Next. Since cider-decompile depends on cider, it has to be installed and running. Start cider session like this:

<kbd>M-x cider-jack-in [RET]</kbd>

Plugin cider-decompile doesn't compile the functions, you need to do this manually for now (this is the place for future enhancements). Easiest way to compile the whole project is to run the command

```sh
$ lein jar
```

Check the target/classes directory: it should contain compiled classes. If the directory is empty -- check your project.clj file. Add `:aot :all` option to it so that leiningen will have to compile ahead-of time all the clojure code.

Let's say, we've got the following namespace in the Clojure project: `myns.core`. Switch to this namespace in the cider buffer.

```lisp
(in-ns 'myns.core)
```

Now you may decompile any function in the current namespace using command `cider-decompile-func`. For instance, if you have function myns.core/main, then you may decompile it like this:

<kbd>M-x cider-decompile-func [RET] main [RET]</kbd>

If you want to decompile a function from the other namespaces, you may use command `cider-decompile-ns-func`. For example, decompiling function myotherns.core/other-main would look like this:

<kbd>M-x cider-decompile-ns-func [RET] myotherns.core/other-main [RET]</kbd>

You need to run these commands from one of the buffers belonging to the project. Cider-decompile uses the buffer to get the relative path to target/classes.

After the command was invoked, the buffer *decompiled* apears showing the bytecode of the function.

Note: you may not decompile variables or macros. Pay attention on what you are decompiling: your function should be defined with `defn`.
