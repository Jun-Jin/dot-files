#!/bin/sh

function sshls () {
  local SSH_CONFIG=$HOME/.ssh/config

  echo "known hosts:"
  if test -e $SSH_CONFIG; then
    for i in `grep -e "^Host " $SSH_CONFIG | sed -e s/"^Host "//`
    do
      echo "  - ${i}"
    done
  else
    echo "No ssh configuration."
  fi
}
