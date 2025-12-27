# command
alias l="ls -G"
alias ls="ls -G"
alias ll="ls -laG"

# application
alias ni="nvim"
alias niew="nvim -R"
alias p3="python3.10"

# location
alias cdc="cd ~/.config"
alias cdw="cd ~/works"
alias cdwj="cd ~/works/jun-jin"
alias cdwi="cd ~/works/infigate"
alias cdwis="cd ~/works/infigate/simulation"
alias cdi="cd ~/works/infigate"
alias cdia="cd ~/works/infigate/arent"
alias cdiaa="cd ~/works/infigate/arent/arent-frontend"
alias cdsig="cd ~/works/infigate/ikusa/system"
alias cdsim="cd ~/works/infigate/ikusa/admin"
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias cdcn="cd ~/.config/nvim"

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
