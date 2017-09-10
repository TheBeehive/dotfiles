### ~/.bash_profile: Runtime configuration for login `bash`

insert_path() {
  [[ -d "$1" && :"$PATH": != *:"$1":* ]] && export PATH="$1:$PATH"
}

insert_path /usr/sbin
insert_path /Applications/Postgres.app/Contents/Versions/latest/bin
insert_path /usr/local/bin
insert_path /usr/local/sbin
insert_path ~/.local/bin

unset -f insert_path

export EDITOR="$(type -p nvim vim vi nano 2> /dev/null | head -1)"
export MAKEFLAGS='-j8'

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

# GPDB
export GPDB5="$HOME/workspace/gpdb"
ulimit -n 65536 65536
ulimit -c unlimited
export PGHOST=localhost
export TMPDIR=/tmp

mkdir -p "$HOME/.ssh"

# from http://stackoverflow.com/questions/18880024/start-ssh-agent-on-login/18915067#18915067
SSH_ENV="$HOME/.ssh/environment"

# Refresh the PATH per new session
sed -i .bak '/^PATH/d' ${SSH_ENV}
echo "PATH=$PATH" >> ${SSH_ENV}

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    source "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} 2>/dev/null | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

[ -f ~/.bashrc ] && source ~/.bashrc

# vim: set ft=sh:
### ~/.bash_profile: Runtime configuration for login `bash`
