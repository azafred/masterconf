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
