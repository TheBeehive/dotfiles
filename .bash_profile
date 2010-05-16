### ~/.bash_profile: Sourced by all login bash shells on startup

export EDITOR="/usr/bin/vim"
export PAGER="/usr/bin/less"

source ~/.bashrc

[ -x /usr/bin/screen ] &&
[[ $TERM != screen* ]] &&
  exec /usr/bin/screen -D -R
