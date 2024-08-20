#!/bin/sh

# Usage: 
# - vpn.sh [start|stop|toggle] -> starts/stops the vpn
# - vpn.sh -> returns vpn status icon if no parameter is provided

if  [[ "$1" == "start" ]]; then
    openvpn3 session-start --config ~/.config/openvpn/anarchy.ovpn
elif [[ "$1" == "stop" ]]; then
    openvpn3 session-manage --disconnect -c ~/.config/openvpn/anarchy.ovpn
elif [[ "$1" == "toggle" ]]; then
    connection=$(openvpn3 sessions-list)

    if [[ "$connection" == "No sessions available" ]]; then
        openvpn3 session-start --config ~/.config/openvpn/anarchy.ovpn
    else 
        openvpn3 session-manage --disconnect -c ~/.config/openvpn/anarchy.ovpn
    fi
else
    connection=$(openvpn3 sessions-list)

    if [[ "$connection" == "No sessions available" ]]; then
        echo "󰦞"
    else 
        echo "󰕥"
    fi
fi
