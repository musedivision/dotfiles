SHELL:=/bin/bash

gitignore_list := $(shell cat .gitignore | sed -e 's/.vim\///g' | tr '\n' ' ') 

install:
	mkdir -p tmp
	cp -rf ~/.vim ./tmp/.
	cp -rf .vim ~/.
	cp .ctags ~/.
	cp .tmux.conf ~/.
	cp .zshrc ~/.


save:
	# its easier to ignore files with rsync
	rsync -rv --progress  $(foreach path, $(gitignore_list), --exclude $(path)  ) ~/.vim .
	cp ~/.ctags .
	cp ~/.tmux.conf .
	cp ~/.zshrc .
