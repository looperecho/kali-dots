
# Set The prompt
precmd() {

    # Find screen session
    if [[ -n "$STY" ]]; then
        SCREEN_SESSION="%F{0}Screen%f "
    else
        SCREEN_SESSION=
    fi
    
    # Find venv
    if [[ -n "$VIRTUAL_ENV" ]]; then
        VENV_NAME=$(basename "$VIRTUAL_ENV")
        PY_VENV="%F{6}$VENV_NAME%f "
    else
        PY_VENV=
    fi

    # Find Git Branch
    if [[ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
        BRANCH_NAME=$(git branch --show-current 2>/dev/null)
        GIT_BRANCH="%B%F{3} : %F{5}$BRANCH_NAME%f%b"
    else
        GIT_BRANCH=
    fi

    # Format working directory
    HOMEICON="~"
    DIRSEP="▸"
    CUSTOMDIR=$(echo "$PWD" | sed "s|^$HOME|%F{4}$HOMEICON|;s|/| %F{8}$DIRSEP%F{4} |g")

    # Set the directory format
    PRINTDIR="$PY_VENV$CUSTOMDIR$GIT_BRANCH"
    
    # Set the prompt symbol
    PSYMBOL="%(?.%F{5}❯.%F{1}❯) "

    # Default mode
    DEFAULT="
%F{8}╭───(%F{7}%T%F{8})──[$PRINTDIR%F{8}]
%F{8}╰─ %(?.%F{4}➜.%F{1}➜) "

    # Compact mode
    COMPACT="
 $PRINTDIR
 $SCREEN_SESSION$PSYMBOL"

    # >>> Set the prompt mode here ( DEFAULT or COMPACT )
    PROMPT="$COMPACT"

}

