# Alias source file. Referenced in .zshrc

# ┌──────── LS 
# ▼
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias las='ls -lah'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
# ▼ Modify LS_COLORS for STICKY_OTHER_WRITABLE dirs
LS_COLORS="${LS_COLORS}:ow=34;40"
export LS_COLORS
export LSCOLORS=ExFxBxDxCxegedabagacad


# ┌──────── SSH 
# ▼


# ┌──────── Directory Exports 
# ▼


# ┌──────── Script Shortcuts 
# ▼


# ┌──────── Shortcuts 
# ▼
# ▼ Package Manager


# ▼ Edit zsh etc.
alias editzsh="e $ZSH_DIR/.zshrc"
alias editalias="e $ZSH_DIR/aliases.zsh"
alias editprompt="e $ZSH_DIR/prompt.zsh"
alias editplugins="e $ZSH_DIR/plugins.zsh"
alias reload="exec $SHELL"

# ▼ Jump to exported locations


# ▼ Other
alias nv="nvim"
alias envoff="source deactivate"


# ┌──────── Functions 
# ▼

# ▼ Activate venv
envon() {
    source "envon.sh" "$1"
}


# ┌──────── . 
# ▼
