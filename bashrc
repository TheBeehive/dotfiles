### ~/.bashrc: Runtime configuration for interactive `bash`

# color the prompt depending on if we're root or not
if [ `id -u` -eq 0 ]; then
  PS1='\[\e[31;01m\]\u\[\e[m\]'
else
  PS1='\[\e[32;01m\]\u\[\e[m\]'
fi
PS1=$PS1' \[\e[36m\]\w\[\e[m\]: '
# change the title if we're in xterm or screen
if [[ $TERM == xterm* ]]; then
  PS1='\[\e]0;\u \w\a\]'$PS1
elif [[ $TERM == screen* ]]; then
  PS1='\[\e]0;\u \w\a\]'$PS1
  PS1='\[\ek\u \w\e\\\]'$PS1
fi
export PS1 PS2='> '

# enable color in `ls`
if ls --color -d . &> /dev/null; then
  # this is GNU ls
  alias ls='ls --color'
elif ls -G -d . &> /dev/null; then
  # this is BSD ls
  alias ls='ls -G'
fi

# enable color in `grep`
if echo x | grep --color x &> /dev/null; then
  alias grep='grep --color'
fi

# enable alias expansion for `sudo`
alias sudo='sudo '

export EDITOR=/usr/bin/vim

# Tell octave, maxima, and R to be silent
alias octave='octave -q'
alias maxima='maxima -q'
alias r='R'
alias R='R -q --no-save'

# Do not auto compile and cache
alias python='python2 -B'

### ~/.bashrc: Runtime configuration for interactive `bash`
