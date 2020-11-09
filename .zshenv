export ZDOTDIR="$HOME/.zsh/"
export TERM=xterm-kitty
export CONFIG="$HOME/.config/"
export RTV_BROWSER=microsoft-edge-dev
export _JAVA_AWT_WM_NONREPARENTING=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export LANG=en_US.UTF-8
export {VISUAL,RTV_EDITOR}=/usr/bin/vim
export STUDIO_JDK=/usr/lib/jvm/java-14-openjdk
typeset -U PATH path
path=("$HOME/.local/bin" "$(ruby -e 'puts Gem.user_dir')/bin" "$path[@]")
export PATH 
