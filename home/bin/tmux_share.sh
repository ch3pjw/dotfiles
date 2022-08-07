#!/bin/bash

# This script starts up a tmux session that can be shared by another user

help ()
{
    echo "Usage: $0 [rw|ro]"
}

do_tmux ()
{
    mode=$1
    socket=/tmp/tmux_share_socket
    mode_file=/tmp/tmux_share_mode
    # Unlock the guest account so our guest can get to our session - Linux
    sudo usermod -U guest
    # Unlock the guest account so our guest can get to our session - Mac
    #sudo pwpolicy -u guest -setpolicy isDisabled=0
    echo ${mode} > ${mode_file}
    # After tmux starts we need to chmod the socket it creates to make it
    # readable by everyone. This starts a subshell that does that in a
    # delayed way. This is not robust, but it's the best I could come up
    # with in limited time!
    (sleep 2; chmod 777 ${socket}) &
    TERM=xterm-256color
    tmux -S ${socket}
    rm -f ${socket}
    rm ${mode_file}
    # lock the guest account now we're done with it - Linux
    sudo usermod -L guest
    # lock the guest account now we're done with it - Mac
    #sudo pwpolicy -u guest -setpolicy isDisabled=1
}

if [[ -z $1 ]]; then
    help
    exit 0
fi

# Source my zshrc so that tmux alias gets made, making it use full colour :)
source ~/.zshrc

case "$1" in
    rw)
        do_tmux rw
        exit $?
        ;;
    ro)
        do_tmux ro
        exit $?
        ;;
    *)
        help
        exit 1
        ;;
esac

# guest's .bashrc should contain:
#socket=/tmp/tmux_share_socket
#mode=/tmp/tmux_share_mode
#alias tmux='TERM=xterm-256color tmux'
#if [[ $(cat ${mode}) == 'rw' ]]; then
#        tmux -S ${socket} attach
#else
#        tmux -S ${socket} attach -r
#fi
#exit 0
