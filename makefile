SHELL:=/bin/bash
.PHONY: filter
# i
# quite a hard process, what is the master for dotfiles. 
# is it your most used?
# Should you endeavour to 
# 



gitignore_list := $(shell cat .gitignore | sed -e 's/.vim\///g' | tr '\n' ' ') 

diff:
	git diff --no-index ~/.vim ./.vim

install:
	mkdir -p tmp
	cp -rf ~/.vim ./tmp/.
	cp -rf .vim ~/.
	cp .ctags ~/.
	cp .tmux.conf ~/.
	# local filter
	cat ./.zshrc > ./tmp/clean.zshrc
	$(MAKE) filter



filter:
	@echo "dont commit sensitive shit"
	(echo "export ZSH="$$HOME/.oh-my-zsh""; cat tmp/clean.zshrc)  > ~/.zshrc 
	

save: 
	# local dirty -> agnostic copy
	# its easier to ignore files with rsync
	rsync -rv --progress  $(foreach path, $(gitignore_list), --exclude $(path)  ) ~/.vim .
	cp ~/.ctags .
	cp ~/.tmux.conf .
	# remove all local specific config MATE
	tail -n +2 ~/.zshrc > ./.zshrc
