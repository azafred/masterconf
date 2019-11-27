#
# Aliases for all Computers
#

# Builtin aliases
alias ll='ls -lhtr'
alias la='ls -a'
alias lla='ls -alhtr'
alias cl='clear'
alias lsd='ls -d */'

# Some cd aliases
alias back='cd -'



# ......
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias ........='cd ../../../../../../../'
alias .........='cd ../../../../../../../../'
alias ..........='cd ../../../../../../../../../'
alias ...........='cd ../../../../../../../../../../'
alias ............='cd ../../../../../../../../../../../'

# ZSH Global Aliases
alias -g L=' | less'
alias -g T=' | tail -20'
alias -g NUL=' > /dev/null 2>&1'

# I like to be safe...
# alias rm='rm -i'

alias vi='vim'
alias _='sudo '
alias psa='ps awxo "user,pid,ppid,%cpu,%mem,tty,state,etime,command" '
alias md='mkdir -p'
alias d='dirs -v'
alias reload='echo Freds ZSH reloading...;cd ~/masterconf/ && git pull --rebase && source ~/.zshrc && echo "Completed."'
alias qreload='source ~/.zshrc'
alias df='df -h'
alias grep='grep --color'
alias dush="du -smh *|sort -n|tail"
alias hashline="printf "%`tput cols`s"|tr ' ' '#'"
alias dateh='date --help|sed -n "/^ *%%/,/^ *%Z/p"|while read l;do date +\ %${l/% */}:\|" |${l/% */}|${l#* }";done|column -s"|" -t'
alias randomfact='wget randomfunfacts.com -O - 2>/dev/null | grep \<strong\> | sed "s;^.*<i>\(.*\)</i>.*$;\1;"'
alias webserver='python -m SimpleHTTPServer'
alias memdump='sudo dd if=/dev/mem | cat | strings'
alias sh_bcast='mkfifo /tmp/fifo;(nc -q0 -l 5000 < /tmp/fifo &);script -f /tmp/fifo'
alias sup='svn up && svn status && svn info && svn log -l 5 -v'
alias bak="cp $1{,.`date +%Y%m%d`}"
alias glog='git log --graph --oneline --all --decorate --color --pretty=format:"%h - %Cred%an%Creset,%ar >> %Cgreen%s%Creset <<%n"'

alias mge='cd ~/co/manage'
alias mger='cd ~/co/manage-released'
alias ans='cd ~/co/manage/extra/ansible/'


# derp derp
alias mkdirp='mkdir -p'

# Alias Git, moved most other aliases to ~/.gitconfig
# For some reason, Git doesn't like capitalized aliases. Some must remain.
alias g='git'
alias gp='git pull'
alias gP='git push'


alias dev="ssh dev131"
alias jump="ssh dal0"
alias co="cd ~/co/manage"
alias machines=/home/fred/co/manage/script/machines
alias m=machines
alias cdr="cd /var/local/meraki/manage-released"
alias cdd="cd /var/local/meraki/manage-devel"
alias cdw="cd /var/www/meraki/manage.meraki.net"
alias sm="sudo -u meraki"
alias qu="(cdr && sudo script/deploy/chruby_bundle_wrapper.sh -- quick_upgrade)"
alias tpsql="psql -U meraki_test_helper -h development-db.meraki.com -d meraki_test_$USER"
alias dpsql="psql -U www-data meraki_development -h development-db.meraki.com"
alias sdpsql="psql -U www-data meraki_shard_development -h shard-development-db.meraki.com"
alias sqlt='/var/local/meraki/router-meraki-production-grabbers/sqlt/sqlt localhost'
alias dsqlt='/var/local/meraki/router-meraki-devel-grabbers/sqlt/sqlt development-lt'
# bundler aliases
alias bi="bundle install --no-prune --local"
alias be="bundle exec"
alias sube="sudo bundle exec"
alias smbe="sudo -u meraki bundle exec"
#useful in devel, auto-bundle-installs if a new gem was installed since you svn-up'd, not to be used in prod
alias cbc="bundle check"
alias bce='cbc || (echo "Installing newly added gems..." && bi) && be'
alias bci='cbc || echo "Installing newly added gems..." && bi'

alias ecn='bundle exec /var/local/meraki/manage-released/script/elasticsearch/cluster_nodes.rb --cluster'
