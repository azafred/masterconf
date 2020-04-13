# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"

# Bootstrap Self...
if [ ! -d ~/masterconf ]; then
   echo "Masterconf not found. Gitting it."
   git clone https://github.com/azafred/masterconf.git $HOME/masterconf || (echo "Failed to Clone" ; exit)
   cd ~/masterconf && ./init.sh
fi

if [ ! -d ~/.fzf ]; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc >/dev/null 2>&1
fi

function update {
    echo "Updating masterconf..."
    cd ~/masterconf && git pull && ./init.sh
    rm ~/.last_updated ; touch ~/.last_updated
    cd ~/
}

# if [ ! -f ~/.last_updated ]; then
#     update
# elif [[ $(find "/home/$USER/.last_updated" -mtime +5 -print) ]]; then
#     update
# fi
cd ~/masterconf
[ $(git rev-parse HEAD) = $(git ls-remote $(git rev-parse --abbrev-ref @{u} | \
sed 's/\// /g') | cut -f1) ] && echo up to date || update
cd ~/


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
