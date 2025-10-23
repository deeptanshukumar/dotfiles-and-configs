#!/bin/bash

# Direction: left = prev, right = next
direction=$1  

# Get active window ID
win_id=$(xdotool getactivewindow)

# Get current workspace index
current_ws=$(wmctrl -d | awk '/\*/ {print $1}')

# Count total workspaces
total_ws=$(wmctrl -d | wc -l)

if [ "$direction" == "left" ]; then
    target_ws=$((current_ws - 1))
    # If no prev workspace, create one
    if [ $target_ws -lt 0 ]; then
        gdbus call --session \
          --dest org.gnome.Shell \
          --object-path /org/gnome/Shell \
          --method org.gnome.Shell.Eval \
          "global.workspace_manager.append_new_workspace(true, global.get_current_time());"
        # after creation, shift everything +1
        total_ws=$((total_ws + 1))
        target_ws=$current_ws  # new one created before current
    fi
else
    target_ws=$((current_ws + 1))
    if [ $target_ws -ge $total_ws ]; then
        # create a new workspace at the end
        gdbus call --session \
          --dest org.gnome.Shell \
          --object-path /org/gnome/Shell \
          --method org.gnome.Shell.Eval \
          "global.workspace_manager.append_new_workspace(false, global.get_current_time());"
        total_ws=$((total_ws + 1))
    fi
fi

# Move window to target workspace
wmctrl -i -r $win_id -t $target_ws

# Switch to that workspace
wmctrl -s $target_ws

