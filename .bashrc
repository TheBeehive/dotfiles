### ~/.bashrc: Sourced by all interactive bash shells on startup

[ -r /etc/bashrc ] && source /etc/bashrc

# Tell applications to be silent
alias octave='octave -q'
alias maxima='maxima -q'
alias r='R'
alias R='R -q --no-save'

# Do not auto compile and cache
alias python='python2 -B'

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

### ~/.bashrc: Sourced by all interactive bash shells on startup
