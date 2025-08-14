### ~/.bash_profile: Runtime configuration for login `bash`

insert_path() {
  for i in "$@"; do
    [[ -d "$i" && :"$PATH": != *:"$i":* ]] && export PATH="$i:$PATH"
  done
}

insert_path /usr/sbin /usr/bin
insert_path /Applications/Postgres.app/Contents/Versions/latest/bin

if command -v brew > /dev/null || [ -x /opt/homebrew/bin/brew ]; then
  eval "$(brew shellenv 2> /dev/null)"
  eval "$(/opt/homebrew/bin/brew shellenv 2> /dev/null)"
  insert_path "$(brew --prefix ruby)/bin"
fi

insert_path /usr/local/sbin /usr/local/bin ~/.local/bin

unset -f insert_path

export EDITOR="$(type -p nvim vim vi nano 2> /dev/null | head -1)"
export PAGER="$(type -p less more 2> /dev/null | head -1)"

if command -v nproc > /dev/null; then
  export MAKEFLAGS="-j$(nproc)"
else
  export MAKEFLAGS=-j8
fi

# Configure CMake to generate compile_commands.json
export CMAKE_EXPORT_COMPILE_COMMANDS=true

# Configure ~/.tex as the highest priority search path for TEXMF. Note that the
# extraneous colon is important! From the `kpathsea` documentation: If the
# highest-priority search path contains an extra colon (i.e., leading, trailing,
# or doubled), Kpathsea inserts at that point the next-highest-priority search
# path that is defined.
export TEXMFCNF="~/.tex:"

# Create true NTFS symlinks in Cygwin
[ "$OSTYPE" = cygwin ] && export CYGWIN='winsymlinks:native'

# Make Homebrew a little faster
if command -v brew > /dev/null; then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_GITHUB_API=1
  export HOMEBREW_NO_INSTALL_CLEANUP=1
  export HOMEBREW_NO_INSTALL_UPGRADE=1
fi

[ -f ~/.bashrc ] && source ~/.bashrc
