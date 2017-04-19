### ~/.bashrc: Runtime configuration for interactive `bash`

# Color username red if root or green otherwise
if [ `id -u` -eq 0 ]; then
  PS1='\[\e[31;01m\]\u\[\e[m\]'
else
  PS1='\[\e[32;01m\]\u\[\e[m\]'
fi

# Color current working directory cyan
PS1="$PS1"' \[\e[36m\]\w\[\e[m\]: '

# Set the window title in xterm and screen
if [[ $TERM == xterm* ]]; then
  PS1='\[\e]0;\u \w\a\]'"$PS1"
elif [[ $TERM == screen* ]]; then
  PS1='\[\e]0;\u \w\a\]'"$PS1"
  PS1='\[\ek\u \w\e\\\]'"$PS1"
fi

# Export PS1 and set continuation prompt to >
export PS1 PS2='> '

# Don't save duplicate commands to the history
export HISTCONTROL=ignoredups

# Enable color in `ls`
if ls --color -d . &> /dev/null; then
  # This is GNU ls
  alias ls='ls --color'
elif ls -G -d . &> /dev/null; then
  # This is BSD ls
  alias ls='ls -G'
fi

# Enable color in `grep`
if echo x | grep --color x &> /dev/null; then
  alias grep='grep --color'
fi

# Enable alias expansion for `sudo`
alias sudo='sudo '

# Silence some loud tools on startup
alias maxima='maxima -q'
alias octave='octave -q'
alias psql='psql -q'
alias R='R -q --no-save'

# Create and use a cscope database at .cscope
alias mkcscope="`which cscope` -bkqRf .cscope"
alias cscope="`which cscope` -df .cscope"

# Keep our github access token out of github
[ -r ~/.github_api ] && source ~/.github_api

hr() {
  local column="$(tput cols)"
  if ((column <= 0)); then
    column="${COLUMNS:-80}"
  fi
  printf "%.0s${1:-#}" $(seq 1 $column)
}

if [ "$OSTYPE" = cygwin ]; then
  # Strip .exe from bash completion
  shopt -s completion_strip_exe

  # Use the same command as in OS X
  alias open='cygstart'

  if hash rlwrap 2> /dev/null; then
    alias ghci='rlwrap ghcii.sh'
  else alias ghci='ghcii.sh'; fi
fi

### ~/.bashrc: Runtime configuration for interactive `bash`
