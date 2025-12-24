#!/usr/bin/env bash
UUID="hidetopbar@mathieu.bidon.ca"

if gnome-extensions list --enabled | grep -q "$UUID"; then
  gnome-extensions disable "$UUID"
  
else
  gnome-extensions enable "$UUID"
   "Enabled"
fi

