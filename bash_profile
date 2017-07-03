### ~/.bash_profile: Runtime configuration for login `bash`

insert_path() {
  [[ -d "$1" && :"$PATH": != *:"$1":* ]] && export PATH="$1:$PATH"
}

insert_path /Applications/Postgres.app/Contents/Versions/latest/bin
insert_path /usr/local/bin
insert_path /usr/local/sbin
insert_path /usr/sbin
insert_path ~/.local/bin

unset -f insert_path

export EDITOR="$(which nvim vim vi nano 2> /dev/null | head -1)"
export MAKEFLAGS='-j8'

# Create true NTFS symlinks in Cygwin
if [ "$OSTYPE" = cygwin ]; then
  export CYGWIN='winsymlinks:native'
  export PGDATA='/var/lib/postgresql'
fi

[ -f ~/.bashrc ] && source ~/.bashrc

# vim: set ft=sh:
### ~/.bash_profile: Runtime configuration for login `bash`
