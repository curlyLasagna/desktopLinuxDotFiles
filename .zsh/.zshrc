source /home/luis/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-less-colors
antigen bundle archlinux
antigen bundle docker
antigen bundle docker-compose
antigen bundle denysdovhan/spaceship-prompt
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle ael-code/zsh-colored-man-pages

antigen theme miloshadzic

HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

						# User configuration #
						
unsetopt correct_all

[[ -f $ZDOTDIR/.zshrc.aliases ]] && source $ZDOTDIR/.zshrc.aliases 

stty -ixon
autoload -Uz compinit && compinit -i
kitty + complete setup zsh | source /dev/stdin

antigen apply

# Start Docker daemon 
# RUNNING=`ps aux | grep dockerd | grep -v grep`
# if [ -z "$RUNNING" ]; then
#     sudo dockerd > /dev/null 2>&1 &
#     disown
# fi

# Attaches tmux 
# if command -v tmux >/dev/null 2>&1; then
#     # if not inside a tmux session, and if no session is started, start a new session
#     [ -z "${TMUX}" ] && (tmux attach >/dev/null 2>&1 || tmux)
# fi
