#!/usr/bin/env sh

######################################################################
# @author      : marques-bruno (bmarques68@gmail.com)
# @file        : launch_polybar
# @created     : Thursday Aug 15, 2024 21:14:58 CEST
#
# @description : Runs polybar for each screen connected
######################################################################

polybar_cmd () {
  sleeptime=0
  polybar i3& sleep $sleeptime
  polybar xkeyboard& sleep $sleeptime
  polybar time& sleep $sleeptime
  polybar soundctl& sleep $sleeptime
  polybar networkctl& sleep $sleeptime
  polybar battery& sleep $sleeptime
  polybar powerctl&
}

killall -9 polybar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar_cmd
  done
else
  MONITOR=eDP-1 polybar_cmd &
fi

