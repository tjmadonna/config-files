# Enable colors and change prompt:
autoload -U colors && colors

function git_prompt {
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3-)"
    local branch_truncated="${branch:0:30}"

    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi

    [ -n "${branch}" ] && echo $'\uE725' ${branch}" "
}

export VIRTUAL_ENV_DISABLE_PROMPT=1 # disable (venv) prompt when activated
function python_venv_prompt {
    [ -n "${VIRTUAL_ENV}" ] && echo $'\uE73c' ${VIRTUAL_ENV##*/}" "
}

# This is specific to zsh but you could call $(git_prompt) in your .bashrc PS1 too.
setopt PROMPT_SUBST
PS1=$'%B%{$fg[blue]%}%1~ %{$fg[magenta]%}$(git_prompt)%{$fg[yellow]%}$(python_venv_prompt)%{$reset_color%}> %b'

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.cache/zsh/.zsh_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Enter normal mode in zsh vi mode with ctrl-r:
bindkey '^r' vi-cmd-mode

# Use k to accept autosuggestions
bindkey '^k' autosuggest-accept

# Open new session using tmux
bindkey -s '^f' "tmux-sessionizer\n"

# Add rust tools to path
export PATH=$HOME/.cargo/bin:$PATH

# Add Visual Studio Code (code)
export PATH=/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin:$PATH

# Add Homebrew to path
export PATH=/opt/homebrew/bin:$PATH

# Add node20 to path
export PATH=/opt/homebrew/opt/node@20/bin:$PATH


# Setup tmux-sessionizer
export PATH=$PATH:$HOME/.config/tmux/bin
export PROJ_FILE=$HOME/.config/tmux/projects

# Add mason tools to path
export PATH=$HOME/.local/share/nvim/mason/bin:$PATH

function ff {
    tmux-sessionizer
}

function projectsff {
    nvim $PROJ_FILE
}

function addff {
    # check if input is a directory
    if [ -d "$1" ]; then
        # check if the project file exists
        if ! test -f $PROJ_FILE; then
            echo "Creating $PROJ_FILE"
            touch $PROJ_FILE
        fi

        # check if the project is already in the file
        if grep -q "^$1$" $PROJ_FILE; then
            echo "Project already in $PROJ_FILE"
            return
        fi
        echo "Adding $1 to $PROJ_FILE"
        echo "$1" >> "$PROJ_FILE"
    else
        echo "Not a directory: $1"
    fi
}

function rmff {
    # check if input is a directory
    if [ -d "$1" ]; then
        if test -f $PROJ_FILE; then
            # check if the project is already in the file
            if grep -q "^$1$" $PROJ_FILE; then
                # replace all / in input with \/ to escape them
                echo "Removing $1 from $PROJ_FILE"
                sed -i "" -e "/^${1//\//\\/}$/d" $PROJ_FILE
            else
                echo "Project not in $PROJ_FILE"
                return
            fi
        else
            echo "$PROJ_FILE does not exist"
        fi
    else
        echo "Not a directory: $1"
    fi
}

# macro to kill the docker desktop app and the VM (excluding vmnetd -> it's a service)
function kill-docker {
    ps ax|grep -i docker|egrep -iv 'grep|com.docker.vmnetd'|awk '{print $1}'|xargs kill
}

function kill-port {
    # Check if a port number is provided
    if [ -z "$1" ]; then
      echo "Usage: $0 <port: int>"
      return
    fi

    # Check if the port number is a number
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
      echo "Port argument must be a number"
      return
    fi

    PORT=$1

    # Find the process ID (PID) using the specified port
    PID=$(lsof -t -i:$PORT)

    # Check if a process is found
    if [ -z "$PID" ]; then
      echo "No process found running on port $PORT"
      return
    fi

    # Loop through each process ID and kill it
    for id in $PID; do
      kill -9 $id
    done

    echo "Processes running on port $PORT has been killed"
}

# Load zsh-syntax-highlighting and zsh-autosuggestions; should be last.
source $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source $HOME/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# check if the current directory is $HOME
if [ "$PWD" = "$HOME" ]; then
    cd $HOME/Development
fi
