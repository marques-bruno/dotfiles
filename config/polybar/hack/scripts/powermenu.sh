#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="~/.config/polybar/hack/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/powermenu.rasi"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
hibernate=" Hibernate"
logout=" Logout"
noconfirm="true"

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $dir/confirm.rasi
}

# Message
msg() {
	rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$lock\n$hibernate\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"

if [[ $chosen != "$lock" ]]; then
	if [[ $noconfirm != "true" ]]; then
		ans=$(confirm_exit &)
		
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			ans="yes"
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			ans="no"
		fi
	else
		ans="yes"
	fi
fi

case $chosen in
    $shutdown)
		if [[ $ans == "yes" ]]; then
			systemctl poweroff
		elif [[ $ans == "no" ]]; then
			exit 0
	        else
			msg
	        fi
        ;;
    $reboot)
		if [[ $ans == "yes" ]]; then
			systemctl reboot
		elif [[ $ans == "no" ]]; then
			exit 0
        	else
			msg
        	fi
        ;;
    $lock)
		if [[ -f /usr/bin/i3lock ]]; then
			$HOME/.bin/scripts/lock
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    $hibernate)
		if [[ $ans == "yes" ]]; then
			mpc -q pause
			amixer set Master mute
			systemctl hibernate
		elif [[ $ans == "no" ]]; then
			exit 0
        	else
			msg
        	fi
        ;;
    $logout)
		if [[ $ans == "yes" ]]; then
			if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
				i3-msg exit
			else 
				# Temporary hack: ly doesn't set neither XDG_DESKTOP_SESSION nor DESKTOP_SESSION
				echo "KAPOUE"
				i3-msg exit
			fi
		elif [[ $ans == "no" ]]; then
			exit 0
        	else
			msg
	        fi
        ;;
esac
