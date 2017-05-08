### ~/.bash_profile: Runtime configuration for login `bash`

if [[ -d /Applications/Postgres.app/Contents/Versions/latest/bin &&
    ":$PATH:" != *:/Applications/Postgres.app/Contents/Versions/latest/bin:* ]]; then
  PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
fi
if [[ -d /usr/local/bin && ":$PATH:" != *:/usr/local/bin:* ]]; then
  PATH="/usr/local/bin:$PATH"
fi
if [[ -d /usr/local/sbin && ":$PATH:" != *:/usr/local/sbin:* ]]; then
  PATH="/usr/local/sbin:$PATH"
fi

if [[ -d /usr/sbin && ":$PATH:" != *:/usr/sbin:* ]]; then
  PATH="/usr/sbin:$PATH"

if [[ -d ~/.local/bin && ":$PATH:" != *:~/.local/bin:* ]]; then
  PATH="~/.local/bin:$PATH"

fi
export PATH

export EDITOR="$(which nvim vim vi nano 2> /dev/null | head -1)"

# Create true NTFS symlinks in Cygwin
if [ "$OSTYPE" = cygwin ]; then
  export CYGWIN='winsymlinks:native'
fi

export PGDATA='/var/lib/postgresql'

[ -r ~/.bashrc ] && source ~/.bashrc

### ~/.bash_profile: Runtime configuration for login `bash`
