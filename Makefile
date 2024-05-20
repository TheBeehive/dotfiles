MAKEROOT := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
OSTYPE := $(shell echo $$OSTYPE)

define \n


endef

.PHONY: bash gem git mintty rake script tex vim

install: bash gem git mintty rake script tex vim

bash:
	ln -sf "${MAKEROOT}"/bash_logout ~/.bash_logout
	ln -sf "${MAKEROOT}"/bash_profile ~/.bash_profile
	ln -sf "${MAKEROOT}"/bashrc ~/.bashrc
	ln -sf "${MAKEROOT}"/inputrc ~/.inputrc

gem:
	ln -sf "${MAKEROOT}"/gemrc ~/.gemrc

git:
	ln -sf "${MAKEROOT}"/gitconfig ~/.gitconfig
	cp -f "${MAKEROOT}"/gitconfig_user ~/.gitconfig_user
	ln -sf "${MAKEROOT}"/gitignore ~/.gitignore

mintty:
ifeq ($(OSTYPE),cygwin)
	ln -sf "${MAKEROOT}"/minttyrc ~/.minttyrc
endif

rake:
	ln -sfn "${MAKEROOT}"/rake ~/.rake

script: $(wildcard script/*)
	mkdir -p ~/.local/bin
	$(foreach s,$^,ln -sf $(MAKEROOT)/$(s) ~/.local/bin/$(notdir $(s))${\n})

tex:
	ln -sfn "${MAKEROOT}"/tex ~/.tex

vim: rake
	# Ensure that $$XDG_CONFIG_HOME exists for neovim
	mkdir -p ~/.config
	ln -sf "${MAKEROOT}"/gvimrc ~/.gvimrc
	ln -sfn "${MAKEROOT}"/vim ~/.config/nvim
	ln -sfn "${MAKEROOT}"/vim ~/.vim
	ln -sf "${MAKEROOT}"/vimrc ~/.vimrc
	vim -c "let g:plug_window = ''" +PlugInstall -c 'qa!'
