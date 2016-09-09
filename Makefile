MAKEROOT:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
OSTYPE:=$(shell echo $$OSTYPE)

install:
	ln -sf "${MAKEROOT}"/bash_logout ~/.bash_logout
	ln -sf "${MAKEROOT}"/bash_profile ~/.bash_profile
	ln -sf "${MAKEROOT}"/bashrc ~/.bashrc
	ln -sf "${MAKEROOT}"/gemrc ~/.gemrc
	ln -sf "${MAKEROOT}"/gitconfig ~/.gitconfig
	ln -sf "${MAKEROOT}"/gvimrc ~/.gvimrc
	ln -sf "${MAKEROOT}"/inputrc ~/.inputrc
ifeq ($(OSTYPE),cygwin)
	ln -sf "${MAKEROOT}"/minttyrc ~/.minttyrc
endif
	ln -sfn "${MAKEROOT}"/vim ~/.vim
	ln -sf "${MAKEROOT}"/vimrc ~/.vimrc

	vim -c "let g:plug_window = ''" +PlugInstall -c 'qa!'
