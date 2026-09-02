.PHONY: install deps

# symlink everything into ~ (backs up whatever it replaces)
install:
	./install.sh

# what the configs actually want on PATH
deps:
	sudo apt-get update && sudo apt-get install -y \
		vim tmux ripgrep universal-ctags fzf xclip \
		zsh zsh-autosuggestions zsh-syntax-highlighting
