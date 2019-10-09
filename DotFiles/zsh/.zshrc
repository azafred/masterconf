# Bootstrap Self...
if [ ! -d ~/masterconf ]; then
   echo "Masterconf not found. Gitting it."
   git clone https://github.com/azafred/masterconf.git $HOME/masterconf || (echo "Failed to Clone" ; exit)
   cd ~/masterconf && ./init.sh
fi

if [ ! -d ~/.fzf ]; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
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

for f in $(find ~/.zsh/ -name '*.zsh' | grep -v .p10k); do 
    # echo "Loading $f";  ## For debugging!
    source $f; 
done
