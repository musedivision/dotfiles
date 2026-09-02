# dotfiles

vim, tmux and zsh config. Symlinked into `~`, so editing `~/.vimrc` edits
this repo — no copying back and forth.

## install

```sh
git clone https://github.com/musedivision/dotfiles ~/dotfiles
cd ~/dotfiles
make deps      # apt: vim tmux ripgrep ctags fzf xclip zsh (+ zsh plugins)
make install   # symlink into ~, then install vim plugins
```

`install.sh` backs up anything real it would replace to `<file>.bak-<timestamp>`.
`.zshrc` is opt-in: `INSTALL_ZSHRC=1 ./install.sh`.

## changes

```sh
$EDITOR ~/.vimrc          # same file as .vim/.vimrc here
git commit -am "..." && git push
```

## keys

**tmux** — prefix `C-a`

| key | |
|---|---|
| `hjkl` | switch pane |
| `C-hjkl` | resize pane |
| `v` / `s` | split side-by-side / stacked, keeping cwd (as vim `C-w v` / `C-w s`) |
| <code>&#124;</code> / `-` | the same two splits, by shape |
| `c` | new window, keeping cwd |
| `S` / `w` | choose session / window |
| `u` | re-run last command in the other pane |
| `r` | reload config |
| `F12` | (no prefix) mute this tmux, for nested sessions |

**vim** — leader `\`

| key | |
|---|---|
| `C-p` | fuzzy-find files |
| `C-f` | search file contents (ripgrep) |
| `C-n` / `C-m` | NERDTree toggle / find current file |
| `\b` / `\.` | buffers / tags |
| `C-h` / `C-l` | prev / next tab |
| `\w` `\q` | write / quit |
| `\f` `\r` | find / replace word under cursor |
| `\,` | clear search highlight |
| `\y` / `\Y` | yank to system clipboard (via OSC52 over tmux/ssh) |
| `\hr` | revert git hunk |
| `\p` | format buffer (ALE -> prettier/eslint) |
| `[w` / `]w` | prev / next lint warning |
| `\dd` `\do` | Goyo on / off |

Machine-specific shell bits go in `~/.zshrc.local`, which is not tracked.

## plugins

12, down from 23. fzf + nerdtree for finding, fugitive + gitgutter for git,
surround + repeat + nerdcommenter for editing, ALE for lint and format,
oceanic-next + airline + goyo for looks.
