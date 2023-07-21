# Japanese settings
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8

# Complement settings
# Use compinit
autoload -Uz compinit
compinit
# Auto correct commands
setopt correct
# Hit correct large character
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# Chose correct commands by arrow key
zstyle ':completion:*:default' menu select=2

# Directory switch settings
# Omit cd command
setopt auto_cd
# Auto pushd
setopt auto_pushd
setopt pushd_ignore_dups

# History settings
# Share history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt histignorealldups
# Auto print date in history
alias history='fc -lt '%F %T' 1'

# Shell looks settings
source "$ZDOTDIR/scripts/CreatePrompt.zsh"
PROMPT="$(prompt)"
unsets
unset -f unsets

# Set key bind
xmodmap ~/.Xmodmap/.Xmodmap

# Functions
# Run mkdir and cd at the same time
function mkcd() {
  if [[ -d "$1" ]]; then
    echo "$1 already exists"
    cd "$1" || exit
  else
    mkdir -p "$1" && cd "$1" || exit
  fi
}

# Aliases
alias exz='exec zsh'
alias \$=''
alias \#='sudo'
alias rma='rm -r'
alias ls='ls --color=auto'