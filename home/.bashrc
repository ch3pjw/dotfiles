# .bashrc

# Aliases for fat fingers and convenience
alias lks='ls'
alias lsd='ls'
alias las='ls'
alias ks='ls'
alias l='ls'
alias s='ls'
alias la='ls -a'
alias ll='ls -l'
alias kess='less'
alias cim='vim'

alias pgrep='pgrep -l'
alias view='vim -R'
function mytop {
    if which htop; then
        htop
    else
        `which top` # Musn't recurse! We will do if we define an alias to top
    fi 
}
alias top='mytop'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Enable 256 colours in tmux (needs to be accompanied by
#   set -g default-terminal "screen-256color"
# in ~/.tmux.conf
alias tmux='TERM=xterm-256color tmux'
