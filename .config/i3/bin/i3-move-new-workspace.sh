#!/bin/sh

WS_JSON=$(i3-msg -t get_workspaces)
# Move a container to a new workspace
for i in {1..10} ; do
  if [[ $WS_JSON != *"\"num\":$i"* ]] ; then
      i3-msg move container to workspace $i
      i3-msg workspace number $i
      break
  fi
done
