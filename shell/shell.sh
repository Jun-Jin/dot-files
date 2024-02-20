# command
alias l="ls -G"
alias ls="ls -G"
alias ll="ls -laG"

# application
alias ni="nvim"
alias niew="nvim -R"
alias p3="python3"

alias tree='tree -a -I "\.DS_Store|\.git|node_modules|vendor\/bundle" -N'

function o () {
    if [ $# -eq 0 ];then
        open .
    else
        open $1
    fi
}

function cdl () {
  # cd and ls files with the argument given by stdin
  if [ $# -eq 0 ];then
    echo "Usage: cdl <directory>"
  else
    cd $1 && ls
  fi
}
