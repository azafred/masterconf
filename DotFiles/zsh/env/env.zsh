#
# OS Specific Env Variables
#

if [[ $CURRENT_OS == 'OS X' ]]; then
    # OS X Env Variables
elif [[ $CURRENT_OS == 'Linux' ]]; then
    # Linux Env Variables
fi
if type "keychain" > /dev/null; then
    for k in `grep -l PRIVATE ~/.ssh/* 2>/dev/null`; do keychain --inherit any --quiet $k; done
    [ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
    . $HOME/.keychain/$HOSTNAME-sh
    [ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && . $HOME/.keychain/$HOSTNAME-sh-gpg
fi