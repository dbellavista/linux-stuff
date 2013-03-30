#!/bin/bash
if pgrep "moc" > /dev/null
then
	case "$1" in
		"play")
			mocp -G
			;;
		"next")
			mocp -f
			;;
		"prev")
			mocp -r
			;;
		*)
			echo `mocp -i | grep "^Title:" | sed "s/Title: [0-9]*//"`
			;;
	esac
elif pgrep "spotify" > /dev/null
then
	case "$1" in
   "play")
       key="XF86AudioPlay"
       ;;
   "next")
       key="XF86AudioNext"
       ;;
   "prev")
       key="XF86AudioPrev"
       ;;
		*)
			exit 0
			;;
	esac
	xdotool key --window $(xdotool search --name "Spotify (Premium )?- Linux Preview"|head -n1) $key
fi

exit 0
