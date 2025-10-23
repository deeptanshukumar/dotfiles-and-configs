#!/bin/bash
current=$(gsettings get org.gnome.desktop.notifications show-banners)
if [ "$current" = "true" ]; then
    gsettings set org.gnome.desktop.notifications show-banners false
else
    gsettings set org.gnome.desktop.notifications show-banners true
fi

