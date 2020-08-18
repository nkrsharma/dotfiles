# Add sbin directories to path.
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/sbin:~/.bin

# Turn off flow control (ctrl-s,q)
if [ -t 0 ]; then
  stty -ixon
  stty -ixoff
fi

# Set default editor to vim.
export VISUAL="vim"
export EDITOR=$VISUAL
export SUDO_EDITOR=$VISUAL
export BROWSER="chromium"

# Default to emacs key-bindings.
bindkey -e

# Load colors and completion.
autoload -Uz colors && colors
autoload -Uz compinit && compinit

# Simple prompt.
PROMPT=$'%F{yellow}%n%f@%F{magenta}%m%f:%F{blue}%~%f\n%# '
RPROMPT='%*'

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
zstyle ':completion:*' menu select
zstyle ':completion:*' format '-- %d --'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Key bindings. (taken from https://wiki.archlinux.org/index.php/Zsh)
# Create a zkbd compatible hash; To add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# Setup key accordingly.
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# History search with up/down keys.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

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
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -p'

# Colorized man pages.
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# Colorized commands.
export GREP_COLOR='0;33'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias diff='diff -u --color=auto'
alias ip='ip --color=auto'

# Convenient aliases for common tools.
alias vi='vim'
alias more='less'
alias h='history'
alias feh='\feh -Z --scale-down *.(jpg|jpeg|png|JPG|JPEG|PNG)'

# Check my processes.
alias psme='ps ux'
alias psmet='pstree $USER'

# File associations.
for t in eps ps pdf EPS PS PDF; do
  alias -s $t='run_in_background zathura'
done

for t in avi flv mkv mp3 mp4 mpeg AVI FLV MKV MP3 MP4 MPEG; do
  alias -s $t='run_in_background mpv'
done

for t in c h cc cpp; do
  alias -s $t=vim
done

for t in jpg jpeg png JPG JPEG PNG; do
  alias -s $t='\feh -Z --scale-down'
done

# Utility functions.
run_in_background() {
  echo "$@"
  "$@" >> /tmp/log-$1 2>&1 &
}

# Weather of some cities.
alias wea_kgp='curl "http://wttr.in/Kharagpur,India?m"'
alias wea_sea='curl "http://wttr.in/Seattle,US?m"'
alias wea_mtv='curl "http://wttr.in/Mountain View,US?m"'
alias wea_svl='curl "http://wttr.in/Sunnyvale,US?m"'
