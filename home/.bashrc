# .bashrc

function mytop {
    if which htop; then
        htop
    else
        `which top` # Musn't recurse! We will do if we define an alias to top
    fi 
}

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
alias top='mytop'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
