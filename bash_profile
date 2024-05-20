### ~/.bash_profile: Runtime configuration for login `bash`

insert_path() {
  [[ -d "$1" && :"$PATH": != *:"$1":* ]] && export PATH="$1:$PATH"
}

insert_path /usr/sbin
insert_path /Applications/Postgres.app/Contents/Versions/latest/bin
insert_path /usr/local/bin
insert_path /usr/local/sbin
insert_path /usr/local/opt/ruby/bin
insert_path ~/.local/bin

unset -f insert_path

export EDITOR="$(type -p nvim vim vi nano 2> /dev/null | head -1)"
export PAGER="$(type -p less more 2> /dev/null | head -1)"

if command -v nproc > /dev/null; then
  export MAKEFLAGS="-j$(nproc)"
else
  export MAKEFLAGS=-j8
fi

# Configure ~/.tex as the highest priority search path for TEXMF. Note that the
# extraneous colon is important! From the `kpathsea` documentation: If the
# highest-priority search path contains an extra colon (i.e., leading, trailing,
# or doubled), Kpathsea inserts at that point the next-highest-priority search
# path that is defined.
export TEXMFCNF="~/.tex:"

# Create true NTFS symlinks in Cygwin
if [ "$OSTYPE" = cygwin ]; then
  export CYGWIN='winsymlinks:native'
  export BROWSER="$(command -v cygstart)"
  export PGDATA='/var/lib/postgresql'
  export VAGRANT_HOME="$(cygpath -w ~/.vagrant.d)"
fi

# Make Homebrew a little faster
if command -v brew > /dev/null; then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_GITHUB_API=1
  export HOMEBREW_NO_INSTALL_CLEANUP=1
  export HOMEBREW_NO_INSTALL_UPGRADE=1
fi

[ -f ~/.bashrc ] && source ~/.bashrc
