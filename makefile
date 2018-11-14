SHELL:=/bin/bash

install:
	mkdir -p tmp
	cp -rf ~/.vim ./tmp/.
	cp -rf .vim ~/.

save:
	cp -rf ~/.vim . 
