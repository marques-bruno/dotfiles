#!/bin/bash

# swap Escape key with Caps_Lock
setxkbmap -option "caps:swapescape"

# speedup key repeat rate
xset r rate 200 25

# unlock numpad
numlockx

# NumLock is F13
#xmodmap -e "remove mod2 = Num_Lock" \
#        -e "keycode 77 = F13"

# Use numbers even when numlock is off
xmodmap -e "keysym KP_End = KP_1" \
        -e "keysym KP_Down = KP_2" \
        -e "keysym KP_Next = KP_3" \
        -e "keysym KP_Left = KP_4" \
        -e "keysym KP_Begin = KP_5" \
        -e "keysym KP_Right = KP_6" \
        -e "keysym KP_Home = KP_7" \
        -e "keysym KP_Up = KP_8" \
        -e "keysym KP_Prior = KP_9" \
        -e "keysym KP_Insert = KP_0" \
        -e "keysym KP_Delete = KP_Decimal"

