#
# Functions
#

# Automatically run ls when cd-ing into a directory
cd() {
    builtin cd $* && ls;
}

#Get IP
ip-addr() {
    wget -qO- http://ipecho.net/plain
    echo
}

# Time ZSH startup
zsh-time() {
    time zsh -i -c exit
}

# Run a command or multiple commands without saving it in the $HISTFILE
incognito() {
    if [ -z $EDITOR ]; then
        EDITOR=vim
    fi

    # Create temp for storing commands
    TEMPFILE=`mktemp -q incognito.XXXXXXXX`

    # Prompt for commands, only run if successful
    $EDITOR $TEMPFILE || {
        echo "Invalid return on the editing"
        return
    }

    # Run the script
    sh $TEMPFILE

    # Clean everything up
    rm -f $TEMPFILE
}

# uncompress depending on extension...
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)
                tar xvjf $1;;
            *.tar.gz)
                tar xvzf $1;;
            *.bz2)
                bunzip2 $1;;
            *.rar)
                unrar x $1;;
            *.gz)
                gunzip $1;;
            *.tar)
                tar xvf $1;;
            *.tbz2)
                tar xvjf $1;;
            *.tgz)
                tar xvzf $1;;
            *.zip)
                unzip $1;;
            *.Z)
                uncompress $1;;
            *.7z)
                7z x $1;;
            *)
                echo "'$1' cannot be extracted via >extract<";;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Make a dir and cd into it
mkcd() {
    mkdir -p $1
    cd $1
}

# Make directories if it doesn't exist and touch the file
mktouch() {
    mkdir -p `dirname $1`
    touch $1
}

# Rename a file and keep it in the same location
rename() {
    if [ "$#" -ne 2 ]; then
        echo "usage: $0 path/to/file/old_name new_name"
        return
    fi

    mv $1 `dirname $1`/$2
}

# Duplicate a file to a new name in the same location
dup() {
    if [ "$#" -ne 2 ]; then
        echo "usage: $0 path/to/file/file copied_file"
        return
    fi

    cp $1 `dirname $1`/$2
}

function upgrade_zsh() {
 pushd ~/.zsh ; git pull --rebase; popd
}

function listen () {
        echo "Listening EVERYWHERE: "
        sudo lsof -iTCP -sTCP:LISTEN -P -n | grep '*:'
        echo "Listening on Local only: "
        sudo lsof -iTCP -sTCP:LISTEN -P -n | grep "127.0.0.1:"
        sudo lsof -iTCP -sTCP:LISTEN -P -n | grep "\[\:\:1\]:"
}
function zsh_stats() {
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

function is () {
        psa | grep "$@" | grep -v "grep"
}

function pidof() {
        ps -aux |grep $1 | awk '{print $2}'
}

function netgraf(){
        sudo netstat -an | grep ESTABLISHED | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | awk '{ printf("%s\t%s\t",$2,$1) ; for (i = 0; i < $1; i++) {printf("*")}; print "" }'
}

function dusort() {
    for i in G M K; do du -d1 -hx ./ | grep "[0-9]$i" | sort -nr -k 1; done | less
}

# json formatting helpers
function jcurl {
  curl -s $@ | jsonator
}

# formatters
function jsonator {
  ruby -rubygems -r pp -e 'require "json"; ARGF.each {|l| puts JSON.pretty_generate(JSON.parse(l))}'
}
function objenator {
  ruby -rubygems -r pp -e 'require "json"; pp JSON.parse(ARGF.read)'
}


# parsers
function jcreatedat {
  ruby -rubygems -r pp -e 'require "json"; ARGF.each {|l| puts JSON.parse(l)["created_at"]}'
}

function bofh {
    curl -s http://pages.cs.wisc.edu/\~ballard/bofh/bofhserver.pl |grep 'is:' |awk 'BEGIN { FS=">"; } { print $10; }'
}

function docker_cleanup {
    docker ps -a | grep 'Exit' | awk '{print $1}' | xargs docker rm
}

function dugraph {
    du -x --max-depth=1|sort -rn|awk -F / -v c=$COLUMNS 'NR==1{t=$1} NR>1{r=int($1/t*c+.5); b="\033[1;31m"; for (i=0; i<r; i++) b=b"#"; printf " %5.2f%% %s\033[0m %s\n", $1/t*100, b, $2}'|tac
}

function sf() {
  if [ "$#" -lt 1 ]; then echo "Supply string to search for"; return 1; fi
  printf -v search "%q" "$*"
  include="yml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst"
  exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist"
  rg_command='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{'$include'}" -g "\!{'$exclude'}/*"'
  files=$(eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}')
  [[ -n "$files" ]] && ${EDITOR:-vim} -g $files
}

function local_ppsql() {
  if [ -e "/etc/MERAKI_MASTER_INFO.rb" ]; then
    psql -U www-data meraki_production "$@"
  else
    psql -U www-data meraki_shard_production "$@"
  fi
}

function ar() {
    cd ~/co/manage/extra/ansible/roles/$@
}
