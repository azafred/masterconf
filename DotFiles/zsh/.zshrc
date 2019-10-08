# Bootstrap Self...
if [ ! -d ~/masterconf ]; then
   echo "Masterconf not found. Gitting it."
   git clone --bare https://github.com/azafred/masterconf.git $HOME/masterconf || (echo "Failed to Clone" ; exit)
fi

# Load Antigen
source ~/.zsh/antigen.zsh
antigen init ~/.zsh/.antigenrc

export TERM="xterm-256color"
export LC_CTYPE="en_US.UTF-8"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"

SOURCE=${0%/*}
[[ -f /etc/motd ]] && cat /etc/motd


# Loading the rest of the ZSH config...
SOURCE="~/.zsh"

# Lib

source $SOURCE/lib/completion.zsh
source $SOURCE/lib/git.zsh
source $SOURCE/lib/history.zsh
source $SOURCE/lib/key-bindings.zsh
source $SOURCE/lib/misc.zsh
source $SOURCE/lib/spectrum.zsh
source $SOURCE/lib/termsupport.zsh
source $SOURCE/lib/theme-and-appearance.zsh

# Aliases
source $SOURCE/aliases/aliases.zsh

# Custom things
source $SOURCE/custom/load.zsh
source $SOURCE/custom/z.zsh

# Env settings
source $SOURCE/env/env.zsh

# Various functions
source $SOURCE/functions/functions.zsh
source $SOURCE/functions/tmux.zsh

# Paths
source $SOURCE/path/paths.zsh

# Colors
source $SOURCE/colors/config.zsh
