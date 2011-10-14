### ~/.bashrc: Sourced by all interactive bash shells on startup

[ -r /etc/bashrc ] && source /etc/bashrc

# Tell octave, maxima, and R to be silent
alias octave='octave -q'
alias maxima='maxima -q'
alias r='R'
alias R='R -q --no-save'

# Do not auto compile and cache
alias python='python2 -B'

# To load nt and tt at startup
alias tnt='vim +NERDTreeTlistOpen'

# Set a custom format to use for ps
export PS_FORMAT="user,group,ppid,pid,vsz,rss,sz,pcpu,pmem,start,time,comm"

### ~/.bashrc: Sourced by all interactive bash shells on startup
