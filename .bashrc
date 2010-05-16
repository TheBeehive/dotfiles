### ~/.bashrc: Sourced by all interactive bash shells on startup

# Set a fancier prompt
PS1='\[\e[32;01m\]\u\[\e[m\] \[\e[36m\]\w\[\e[m\]: '
[[ $TERM == xterm* ]] &&
  PS1='\[\e]0;\u \w\a\]'"${PS1}"
[[ $TERM  == screen* ]] &&
  PS1='\[\ek\u \w\e\\\]\[\e]0;\u \w\a\]'"${PS1}"
export PS1

# Turn on colors for ls and grep
alias less='less --RAW-CONTROL-CHARS'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Tell applications to be silent
alias octave='octave -q'
alias maxima='maxima -q'
alias r='R'
alias R='R -q --no-save'

# Set colors for ls and friends
if [ -f ~/.dir_colors ]; then
  eval `dircolors -b ~/.dir_colors`
elif [ -f /etc/dir_colors ]; then
  eval `dircolors -b /etc/dir_colors`
else eval `dircolors -b`; fi

# To load nt and tt at startup
alias tnt='vim +NERDTreeTlistOpen'

# Aliases for man and info pages and to shell betwen hosts
#alias info='_info'; alias man='_man'
#function _man() {
#  vim -R -c 'set ft=man  nonu fdc=0' -c "Man  $1 $2"; }
#function _info() {
#  vim -R -c 'set ft=info nonu fdc=0' -c "Info $1 $2"; }

# Set a custom format to use for ps
export PS_FORMAT="user,group,ppid,pid,vsz,rss,sz,pcpu,pmem,start,time,comm"
