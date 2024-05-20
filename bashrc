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
PROMPT_COMMAND='GIT_BRANCH=$(git_branch)'
PS1="$PS1"'${GIT_BRANCH:+ [\[\e[38;5;9m\]${GIT_BRANCH}\[\e[m\]]}: '

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
  # Set some global options for `fzf`
  declare -a fzf_default_opts=( \
    --cycle
    --height=100%
    --layout=reverse
    --info=inline
    --pointer=▶
    --marker=▶
    --color=gutter:-1
  )
  export FZF_DEFAULT_OPTS="${fzf_default_opts[*]}"
  unset -v fzf_default_opts

  # Use `fd` if available for `fzf`
  command -v fd > /dev/null && export FZF_DEFAULT_COMMAND='fd -Ltf'
fi

# Load bash key bindings for `fzf`
if source /usr/local/opt/fzf/shell/key-bindings.bash 2> /dev/null ||
    source /usr/share/doc/fzf/examples/key-bindings.bash 2> /dev/null; then
  # Set the line as the prompt in `fzf` if it's used in bash completion
  fzf() {
    if [[ ${FUNCNAME[1]} = __fzf_select__ ]]; then
      # Get the text before the cursor and trim it
      local prompt="${READLINE_LINE:0:${READLINE_POINT-${#READLINE_LINE}}}"
      prompt="${prompt%"${prompt##*[![:space:]]}"}"
      [ -n "$prompt" ] && set -- "$@" --prompt "$prompt > "
    fi
    command fzf "$@"
  }

  # Use `fd` if available for CTRL-T and ALT-C
  if command -v fd > /dev/null; then
    FZF_CTRL_T_COMMAND='fd -Ltf' FZF_ALT_C_COMMAND='fd -Ltd'
  fi

  # Preview CTRL-T with `bat` or `head`
  if command -v bat > /dev/null; then
    FZF_CTRL_T_OPTS="
      --preview='bat -pp --color=always -r :\$FZF_PREVIEW_LINES {}'"
  else
    FZF_CTRL_T_OPTS="--preview='head -n \$FZF_PREVIEW_LINES {}'"
  fi

  # Preview ALT-C with `exa` or `ls`. Colorize it if we have `exa`, GNU `ls`,
  # or BSD `ls`.
  if command -v exa > /dev/null; then
    FZF_ALT_C_OPTS="--preview='exa -lh --color=always {}'"
  elif ls --color -d . &> /dev/null; then
    # This is GNU `ls`
    FZF_ALT_C_OPTS="--preview='ls -lho --color=always {} | tail -n+2'"
  elif ls -G -d . &> /dev/null; then
    # This is BSD `ls`
    FZF_ALT_C_OPTS="
      --preview='CLICOLOR_FORCE=1 ls -lhoG {} | tail -n+2'"
  else
    FZF_ALT_C_OPTS="--preview='ls -lho {} | tail -n+2'"
  fi
  FZF_ALT_C_OPTS="$FZF_ALT_C_OPTS --prompt='cd > '"
fi

# Don't save duplicate commands to the history
HISTCONTROL=ignoredups
HISTTIMEFORMAT=$'\b|\e[34m%m/%d/%Y %H:%M:%S\e[m| '

# Alias `ls` to `exa` or enable color in `ls`
if command -v exa > /dev/null; then
  alias ls=exa tree='exa -T'
elif ls --color -d . &> /dev/null; then
  # This is GNU `ls`
  alias ls='ls --color'
elif ls -G -d . &> /dev/null; then
  # This is BSD `ls`
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
