MAKEROOT:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
OSTYPE:=$(shell echo $$OSTYPE)

.PHONY: bash gem git rake vim

install: bash gem git rake vim
ifeq ($(OSTYPE),cygwin)
	ln -sf "${MAKEROOT}"/minttyrc ~/.minttyrc
endif
	ln -sf "${MAKEROOT}"/sqliterc ~/.sqliterc

bash:
	ln -sf "${MAKEROOT}"/bash_logout ~/.bash_logout
	ln -sf "${MAKEROOT}"/bash_profile ~/.bash_profile
	ln -sf "${MAKEROOT}"/bashrc ~/.bashrc
	ln -sf "${MAKEROOT}"/inputrc ~/.inputrc

gem:
	# Make the ~/.local directory so that gem's bindir can be set to ~/.local/bin
	# without gem install failing during a mkdir on ~/.local/bin (due to a ENOENT
	# on ~/.local)
	mkdir -p ~/.local
	ln -sf "${MAKEROOT}"/gemrc ~/.gemrc

git:
	ln -sf "${MAKEROOT}"/gitconfig ~/.gitconfig
	cp -f "${MAKEROOT}"/gitconfig_user ~/.gitconfig_user
	ln -sf "${MAKEROOT}"/gitignore ~/.gitignore

rake:
	ln -sfn "${MAKEROOT}"/rake ~/.rake

vim: rake
	# Ensure that $XDG_CONFIG_HOME exists for neovim
	mkdir -p ~/.config
	ln -sf "${MAKEROOT}"/gvimrc ~/.gvimrc
	ln -sfn "${MAKEROOT}"/vim ~/.config/nvim
	ln -sfn "${MAKEROOT}"/vim ~/.vim
	ln -sf "${MAKEROOT}"/vimrc ~/.vimrc
	vim -c "let g:plug_window = ''" +PlugInstall -c 'qa!'
