# Load ZSH plugins from here

# ┌──── Histfile Config 
# ▼
HISTFILE=$ZSH_DIR/histfile
HISTSIZE=500
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# ┌──── Load Custom Prompt 
# ▼
if [ -f $ZSH_DIR/prompt.zsh ]; then
  source $ZSH_DIR/prompt.zsh
fi


# ┌──── ZSH Syntax Highlighting 
# ▼ 
if [ -f $ZSH_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source $ZSH_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # ▼ Style
	typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
fi


# ┌──── ZSH Auto Suggestions 
# ▼
if [ -f $ZSH_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source $ZSH_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh

    # ▼ Style
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fi


# ┌──── fzf Shell Intergration 
# ▼
# eval "$(fzf --zsh)"
source <(fzf --zsh)


# ┌──── Zioxide 
# ▼
eval "$(zoxide init --cmd cd zsh)"
