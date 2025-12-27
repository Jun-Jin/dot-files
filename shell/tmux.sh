# Tmux session management
# Automatically attach to or create tmux sessions on terminal startup

function tmux_auto_attach() {
  # Skip if already inside tmux
  [[ -n "$TMUX" ]] && return

  # Get list of existing sessions
  local sessions
  sessions=$(tmux list-sessions 2>/dev/null)

  if [[ -z "$sessions" ]]; then
    # No sessions exist, create a new one
    tmux new-session
  else
    # Sessions exist, let user choose
    echo "Existing tmux sessions:"
    echo "$sessions"
    echo ""

    local session_names
    session_names=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)

    if command -v fzf &>/dev/null; then
      # Use fzf for selection if available
      local selected
      selected=$(echo -e "$session_names\n[new session]" | fzf --height=40% --reverse --prompt="Select session: ")

      if [[ -n "$selected" ]]; then
        if [[ "$selected" == "[new session]" ]]; then
          read "session_name?New session name (leave empty for auto): "
          if [[ -z "$session_name" ]]; then
            tmux new-session
          else
            tmux new-session -s "$session_name"
          fi
        else
          tmux attach-session -t "$selected"
        fi
      fi
    else
      # Fallback to simple selection without fzf
      echo "Enter session name to attach (or 'new' for new session):"
      read "choice?"

      if [[ "$choice" == "new" ]]; then
        read "session_name?New session name (leave empty for auto): "
        if [[ -z "$session_name" ]]; then
          tmux new-session
        else
          tmux new-session -s "$session_name"
        fi
      elif [[ -n "$choice" ]]; then
        tmux attach-session -t "$choice"
      fi
    fi
  fi
}
