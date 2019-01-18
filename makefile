SHELL:=/bin/bash

# i
# quite a hard process, what is the master for dotfiles. 
# is it your most used?
# Should you endeavour to 
# 



gitignore_list := $(shell cat .gitignore | sed -e 's/.vim\///g' | tr '\n' ' ') 

install:
	mkdir -p tmp
	cp -rf ~/.vim ./tmp/.
	cp -rf .vim ~/.
	cp .ctags ~/.
	cp .tmux.conf ~/.
#	cp .zshrc ~/.


save:
	# its easier to ignore files with rsync
	rsync -rv --progress  $(foreach path, $(gitignore_list), --exclude $(path)  ) ~/.vim .
	cp ~/.ctags .
	cp ~/.tmux.conf .
	cp ~/.zshrc .
