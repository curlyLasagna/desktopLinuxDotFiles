export ZDOTDIR="/home/luis/.zsh/"
export TERM=xterm-256color
export CONFIG="$HOME/.config/"
export _JAVA_AWT_WM_NONREPARENTING=1
export LANG=en_US.UTF-8
export {VISUAL,RTV_EDITOR,EDITOR}=/bin/vim
export STUDIO_JDK=/usr/lib/jvm/java-14-openjdk
export SVDIR='/home/luis/service'
typeset -U PATH path
path=("$HOME/.local/bin" "$(ruby -e 'puts Gem.user_dir')/bin" "$path[@]")
export PATH 
