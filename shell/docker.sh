alias dim='docker images'
alias dps='docker ps'
alias dpa='docker ps -a'

function dbash () {
  command docker exec -it $1 /bin/bash
}
