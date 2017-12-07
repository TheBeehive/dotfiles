### ~/.bashrc: Runtime configuration for interactive `bash`

# Color username red if root or green otherwise
if [ `id -u` -eq 0 ]; then
  PS1='\[\e[31;01m\]\u\[\e[m\]'
else
  PS1='\[\e[32;01m\]\u\[\e[m\]'
fi

# Color current working directory cyan
PS1="$PS1"' \[\e[36m\]\w\[\e[m\]'

# Color git branch (if available) purple
git_branch() {
  git branch 2> /dev/null | sed -ne '/^\*/s/^\* \(.*\)$/\1/p'
}
if ! [[ $PROMPT_COMMAND =~ GIT_BRANCH=\$\(git_branch\) ]]; then
  PROMPT_COMMAND='GIT_BRANCH=$(git_branch);'"$PROMPT_COMMAND"
fi
PS1="$PS1"'${GIT_BRANCH:+ [\[\e[38;5;9m\]$GIT_BRANCH\[\e[m\]]}: '

# Set the window title in xterm and screen
if [[ $TERM == xterm* ]]; then
  PS1='\[\e]0;\u \w\a\]'"$PS1"
elif [[ $TERM == screen* ]]; then
  PS1='\[\e]0;\u \w\a\]'"$PS1"
  PS1='\[\ek\u \w\e\\\]'"$PS1"
fi

# Set continuation prompt to >
PS2='> '

if command -v fzf > /dev/null; then
  # None of this works in the legacy version of `fzf`
  if [ "$OSTYPE" != cygwin ]; then
    # Set options for `fzf` and reset on resize
    fzf_resize() {
      local -i height
      [ -n "$LINES" ] && height=$LINES || height=$(tput lines)
      export FZF_DEFAULT_OPTS="--inline-info \
        --reverse --height=$(($height - 1)) \
        --preview='head -n $(($height - 3)) {}'"
    }
    fzf_resize; trap fzf_resize WINCH
  fi

  if [ -d /usr/local/opt/fzf ]; then
    # Load key bindings for `fzf`
    source /usr/local/opt/fzf/shell/key-bindings.bash
  fi
fi

# Don't save duplicate commands to the history
export HISTCONTROL=ignoredups

# (Re)source all modified *.sh files in ~/.environment.d
resource_environment_d() {
  [ -d ~/.environment.d -a -x ~/.environment.d ] || return 0

  local nullglob="$(shopt -p nullglob)"
  shopt -s nullglob
  local -a list=(~/.environment.d/*.sh)
  $nullglob

  local -i time source_time=$(date +%s)
  local file

  for file in "${list[@]}"; do
    time=$(perl -e 'print +(stat $ARGV[0])[9]' "$file")
    [ $time -ge ${ENVIRONMENT_TIME:-0} ] && source "$file"
  done

  declare -gi ENVIRONMENT_TIME=$source_time
}
if ! [[ $PROMPT_COMMAND =~ resource_environment_d ]]; then
  PROMPT_COMMAND="resource_environment_d;$PROMPT_COMMAND"
fi

# Enable color in `ls`
if ls --color -d . &> /dev/null; then
  # This is GNU ls
  alias ls='ls --color'
elif ls -G -d . &> /dev/null; then
  # This is BSD ls
  alias ls='ls -G'
fi

alias ll='ls -la'

# Enable color in `grep`
if echo x | grep --color x &> /dev/null; then
  alias grep='grep --color'
fi

# Enable alias expansion for `sudo`
alias sudo='sudo '

# Silence some loud tools on startup
alias maxima='maxima -q'
alias octave='octave -q'
alias R='R -q --no-save'

# Use the cscope database at .cscope
alias cscope='cscope -df .cscope'

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

command -v direnv > /dev/null 2>&1 && eval "$(direnv hook bash)"

# Use chruby and chruby-auto if available
for i in /usr/local/opt/chruby/share/chruby/{chruby,auto}.sh; do
  [ -f $i ] && source $i
done

### ~/.bashrc: Runtime configuration for interactive `bash`
