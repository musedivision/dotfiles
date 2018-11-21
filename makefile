SHELL:=/bin/bash

install:
	mkdir -p tmp
	cp -rf ~/.vim ./tmp/.
	cp -rf .vim ~/.
	cp .ctags ~/.

save:
	cp -rf ~/.vim . 
	cp ~/.ctags .
