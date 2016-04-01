### ~/.bash_profile: Runtime configuration for login `bash`

PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"
export PATH

export C_INCLUDE_PATH='/usr/local/include'

export EDITOR="$(which nvim vim vi nano | head -1)"
export PYTHONPATH="$HOME/Code"

# Create true NTFS symlinks in Cygwin
if [[ "`uname -a`" = *'Cygwin'* ]]; then
  export CYGWIN='winsymlinks:native'
fi

[ -r ~/.bashrc ] && source ~/.bashrc

### ~/.bash_profile: Runtime configuration for login `bash`
