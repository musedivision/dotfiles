# ─────────────────────────────────────────────────────────────
#  .zshrc
# ─────────────────────────────────────────────────────────────

# ── oh-my-zsh (optional — everything below works without it) ─
export ZSH="$HOME/.oh-my-zsh"
if [ -d "$ZSH" ]; then
  ZSH_THEME="robbyrussell"
  plugins=(git docker kubectl fzf)
  source "$ZSH/oh-my-zsh.sh"
fi

# ── history: big, shared, de-duped ───────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY          # live history across panes
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE      # leading space keeps it out of history
setopt HIST_VERIFY            # expand !! before running it
setopt EXTENDED_HISTORY

# ── shell behaviour ──────────────────────────────────────────
unsetopt CASE_GLOB            # case-insensitive globbing
setopt AUTO_CD                # `foo/` instead of `cd foo/`
setopt AUTO_PUSHD             # cd builds a stack, see `dirs -v`
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS

# up/down search history for what's already typed
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# ── completion ───────────────────────────────────────────────
autoload -Uz compinit && compinit -d "$HOME/.cache/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*' list-colors ''

# ── aliases ──────────────────────────────────────────────────
alias tn="tmux new -s"
alias ta="tmux attach"
alias td="tmux detach"
alias tls="tmux list-sessions"
alias tk="tmux kill-session -t"
alias dps="docker ps"

# ── fzf: ripgrep as the source, falling back to ag then find ─
if command -v rg >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
elif command -v ag >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='ag -g ""'
else
  export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/.git/*"'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# ── paths ────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"
export EDITOR=vim
export KUBECONFIG="$HOME/.kube/config"

# GOLANG
if [ -d "$HOME/go" ]; then
  export GOPATH="$HOME/go"
  export PATH="$PATH:$GOPATH/bin"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# z — jump to frecent directories
[ -s "$HOME/z.sh" ] && source "$HOME/z.sh"

# ── plugins: ghost-text suggestions + syntax highlighting ────
# apt install zsh-autosuggestions zsh-syntax-highlighting
# (syntax-highlighting must be sourced last)
for p in \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
do
  [ -f "$p" ] && source "$p"
done

# machine-local overrides, not tracked in git
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
