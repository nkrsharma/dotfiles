## History
HISTSIZE=1000                   # History lines to store in memory
SAVEHIST=1000                   # History lines to save to disk
HISTFILE=~/.histfile            # File to save history to
setopt append_history           # Append instead of replacing history
setopt inc_append_history       # .. do so as commands are entered
setopt extended_history         # Keep timestamps on history entries
setopt hist_ignore_dups         # Remove repeated commands from history
setopt hist_reduce_blanks       # Reformat whitespace in history

zstyle :compinstall filename '/home/naveenks/.zshrc'

autoload -Uz compinit
compinit

## Prompt
PROMPT=$'%{\e[0;31m%}%n@%m%{\e[0m%}:%{\e[0;32m%}%1~%{\e[0m%}\$ '

WORDCHARS=${WORDCHARS//['\/.&']}

## Aliases
alias cd..='cd ..'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias ls='ls -hF --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -lA'
alias lz='ls -lSr'
alias lt='ls -ltr'
alias lc='ls -ltcr'
alias lu='ls -ltur'
alias lm='ls -lA | more'
alias lr='ls -lR'

alias more='less'

alias h='history'
alias R='reset'

alias psme='ps -u $USER'
