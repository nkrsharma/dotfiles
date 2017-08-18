# Add sbin directories to path.
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/sbin

# Turn off flow control (ctrl-s,q)
if [ -t 0 ]; then
  stty -ixon
  stty -ixoff
fi

# Set default editor to vim.
export VISUAL=vim
export EDITOR=$VISUAL

# Default to emacs key-bindings.
bindkey -e

# Load colors and completion.
autoload -Uz colors && colors
autoload -Uz compinit && compinit

# Simple prompt.
PROMPT='%F{red}%n@%m%f%F{green}:%1~%f$ '

# Allow some more words.
WORDCHARS=${WORDCHARS//[-\/.;&]}

# History.
HISTSIZE=1024                     # Lines to store in memory
SAVEHIST=1024                     # Lines to save to disk
HISTFILE=~/.zsh_history           # File on disk

# Directory colors.
eval "$(dircolors -b)"

# General options.
setopt AUTO_CD                    # Perform cd if command is a directory
setopt APPEND_HISTORY             # Append instead of replacing history
setopt CORRECT                    # Try to correct spelling on commands
setopt EXTENDED_HISTORY           # Keep timestamps on history entries
setopt HIST_IGNORE_ALL_DUPS       # Remove repeated commands from history
setopt HIST_IGNORE_SPACE          # Ignore blank commands
setopt HIST_NO_FUNCTIONS          # Don't store function definitions.
setopt HIST_REDUCE_BLANKS         # Reformat whitespace in history
setopt INC_APPEND_HISTORY         # .. do so as commands are entered

setopt NO_BEEP                    # Shhhhh...
setopt NO_HUP                     # Don't HUP background processes on exit
setopt NO_FLOW_CONTROL            # Disable flow control

# Some defaults taken from /etc/zsh/newuser.zshrc.recommended
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format '-- %d --'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# Handy list directory aliases.
alias ls='ls -hFv --color=auto --group-directories-first'
alias ll='ls -l'                  # Long list
alias la='ls -lA'                 # All files.
alias lz='ls -lSr'                # Sort by size.
alias lt='ls -ltr'                # Sort by modified time.
alias lc='ls -ltcr'               # Sort by creation time.
alias lu='ls -ltur'               # Sort by access time.
alias lm='ls -lA | less'          # Show very long list of files.
alias lr='ls -lR'                 # Show folders recursively

# Confirm when overwriting.
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# Colorized grep.
export GREP_COLOR='0;33'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'

# Colorized man pages.
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

alias more='less'
alias h='history'

# Check my processes.
alias psme='ps ux'
alias psmet='pstree $USER'

# File associations.
for t in eps ps pdf; do
  alias -s $t='run_in_background zathura'
done

for t in avi flv mkv mp3 mp4 mpeg; do
  alias -s $t='run_in_background vlc'
done

# Utility functions.
run_in_background()
{
    echo "$@"
    "$@" >> /tmp/log-$1 2>&1 &
}

# Weather of some cities.
alias wea_kgp='curl "http://wttr.in/Kharagpur,India?m"'
alias wea_lax='curl "http://wttr.in/Los Angeles,US?m"'
alias wea_sea='curl "http://wttr.in/Seattle,US?m"'
alias wea_sfo='curl "http://wttr.in/San Francisco,US?m"'
