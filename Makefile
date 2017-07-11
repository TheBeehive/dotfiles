MAKEROOT:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
OSTYPE:=$(shell echo $$OSTYPE)

install:
	# Make the ~/.local directory so that gem's bindir can be set to ~/.local/bin
	# without gem install failing during a mkdir on ~/.local/bin (due to a ENOENT
	# on ~/.local)
	mkdir -p ~/.local

	# Ensure that $XDG_CONFIG_HOME exists for neovim
	mkdir -p ~/.config

	ln -sf "${MAKEROOT}"/bash_logout ~/.bash_logout
	ln -sf "${MAKEROOT}"/bash_profile ~/.bash_profile
	ln -sf "${MAKEROOT}"/bashrc ~/.bashrc
	ln -sf "${MAKEROOT}"/gemrc ~/.gemrc
	ln -sf "${MAKEROOT}"/gitconfig ~/.gitconfig
	cp -f "${MAKEROOT}"/gitconfig_user ~/.gitconfig_user
	ln -sf "${MAKEROOT}"/gitignore ~/.gitignore
	ln -sf "${MAKEROOT}"/gvimrc ~/.gvimrc
	ln -sf "${MAKEROOT}"/inputrc ~/.inputrc
ifeq ($(OSTYPE),cygwin)
	ln -sf "${MAKEROOT}"/minttyrc ~/.minttyrc
endif
	ln -sfn "${MAKEROOT}"/rake ~/.rake
	ln -sf "${MAKEROOT}"/sqliterc ~/.sqliterc
	ln -sfn "${MAKEROOT}"/vim ~/.config/nvim
	ln -sfn "${MAKEROOT}"/vim ~/.vim
	ln -sf "${MAKEROOT}"/vimrc ~/.vimrc

	vim -c "let g:plug_window = ''" +PlugInstall -c 'qa!'
