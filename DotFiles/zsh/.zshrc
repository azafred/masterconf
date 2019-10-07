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

POWERLEVEL9K_PROMPT_ON_NEWLINE=false
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_DISABLE_RPROMPT=false
#POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="↱"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status os_icon context dir background_jobs vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_OS_ICON_BACKGROUND="black"
POWERLEVEL9K_CONTEXT_BACKGROUND="grey"
POWERLEVEL9K_RAM_ELEMENTS=(ram_free)
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S == %d.%m.%y}"
COMPLETION_WAITING_DOTS="false"
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0B1'
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\uE0B3'

