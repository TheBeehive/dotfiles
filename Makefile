MAKEROOT:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

install:
	ln -sf "${MAKEROOT}"/bash_profile ~/.bash_profile
	ln -sf "${MAKEROOT}"/bashrc ~/.bashrc
	ln -sf "${MAKEROOT}"/gitconfig ~/.gitconfig
	ln -sf "${MAKEROOT}"/gvimrc ~/.gvimrc
	ln -sf "${MAKEROOT}"/vimrc ~/.vimrc
