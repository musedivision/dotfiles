#!/usr/bin/env bash
# Symlink the dotfiles into $HOME. Idempotent; backs up anything real
# it would overwrite to <file>.bak-<timestamp>.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d%H%M%S)"

link() {
  local src="$DOTFILES/$1" dest="$HOME/$2"
  if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
    echo "  ok       ~/$2"
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.bak-$STAMP"
    echo "  backed up ~/$2 -> ~/$2.bak-$STAMP"
  fi
  ln -s "$src" "$dest"
  echo "  linked   ~/$2 -> $src"
}

echo "linking dotfiles from $DOTFILES"
link .vim           .vim
link .vim/.vimrc    .vimrc
link .tmux.conf     .tmux.conf
link .ctags         .ctags
[ -n "${INSTALL_ZSHRC:-}" ] && link .zshrc .zshrc

# vim-plug + plugins
if command -v vim >/dev/null 2>&1 && vim --version | grep -q '+eval'; then
  echo "installing vim plugins..."
  vim -es -u "$HOME/.vimrc" -i NONE -c "PlugInstall --sync" -c qa >/dev/null 2>&1 || true
  echo "  done (run :PlugStatus in vim to check)"
else
  echo "  skipped vim plugins: no full vim on PATH (apt install vim / vim-nox)"
fi

# reload tmux if it's running
if command -v tmux >/dev/null 2>&1 && tmux info >/dev/null 2>&1; then
  tmux source-file "$HOME/.tmux.conf" && echo "  tmux config reloaded"
fi

echo "done."
