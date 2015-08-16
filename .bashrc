if [ -t 0 ]; then
  stty stop ''
  stty start ''
  stty -ixon
  stty -ixoff
fi

# prompt
export PS1="\[\e[0;31m\]\u@\h\[\e[m\]:\[\e[0;32m\]\W\[\e[m\]\$ "

# aliases
alias cd..="cd .."
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias h='history'
alias R='reset'

alias ls="ls -hF --color=auto"
alias ll="ls -l --group-directories-first"
alias la='ls -Al'
alias lx='ls -lXB'
alias lk='ls -lSr'
alias lc='ls -ltcr'
alias lu='ls -ltur'
alias lt='ls -ltr'
alias lm='ls -al | more'
alias lr='ls -lR'

alias more='less'

alias psme='ps -u $USER'
