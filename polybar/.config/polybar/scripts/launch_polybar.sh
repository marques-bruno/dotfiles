#!/usr/bin/env sh

######################################################################
# @author      : marques-bruno (bmarques68@gmail.com)
# @file        : launch_polybar
# @created     : Thursday Aug 15, 2024 21:14:58 CEST
#
# @description : Runs polybar for each screen connected
######################################################################

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar &
  done
else
  polybar &
fi

