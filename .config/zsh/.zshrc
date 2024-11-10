# .zshrc

# ┌──── Set zsh directories 
# ▼
export ZSH_DIR="$HOME/.config/zsh"

export KEYBINDINGS="$ZSH_DIR/keys.zsh"
export ALIASES="$ZSH_DIR/aliases.zsh"
export PLUGINS="$ZSH_DIR/plugins.zsh"

export EDITOR="nvim"
export VISUAL="nvim"
alias e="$EDITOR"


# ┌──── Paths 
# ▼


# ┌──── Load Keybindings 
# ▼
if [ -f $KEYBINDINGS ]; then
  source $KEYBINDINGS
fi


# ┌─ Load Aliases 
# ▼
if [ -f $ALIASES ]; then
  source $ALIASES
fi


# ┌──── Load zsh plugins 
# ▼
if [ -f $PLUGINS ]; then
  source $PLUGINS
fi


# ┌──── Pyenv Stuff 
# ▼ 
if [ -d $HOME/.pyenv ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi


# ┌──── Yazi exec and CWD on exit 
# ▼ 
. "$HOME/.cargo/env"

function zi() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
