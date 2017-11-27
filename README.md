# TheBeehive's Dotfiles

A collection of custom user configuration and scripts for Linux, OS X, and
Windows.

## Installation

```sh
git clone git@github.com:TheBeehive/dotfiles.git ~/.dot
make -C ~/.dot
```

Alternatively individual components can be installed. At the moment the
components defined are:
  1. **`bash`** for `bash_logout`, `bash_profile`, `bashrc`, and `inputrc`
  2. **`gem`** for `gemrc`
  3. **`git`** for `gitconfig`, `gitconfig_user`, and `gitignore`
  4. **`mintty`** for `minttyrc`
  5. **`rake`** for global `rake` tasks
  6. **`sqlite`** for `sqliterc`
  7. **`vim`** for `vimrc`, `gvimrc`, the `vim` directory, and all `vim`
     plugins. In addition **`vim`** installs **`rake`** as well for the
     `vim-plug` family of global `rake` tasks.

## Branching

Each user should create their own branch from `master` and update
`gitconfig_user` with their `git` user details.

## A Note on `gitconfig_user`

To support multiple user branches in this repository the user details for `git`
are stored in `gitconfig_user`. When the **`git`** target is run with `make`
this file is copied (instead of symlinked) to `~/.gitconfig_user` and is picked
up by `git` through this section in `~/.gitconfig`:

```gitconfig
[include]
  path = .gitconfig_user
```

This is to prevent the configured `git` user from changing when switching to
another branch.
