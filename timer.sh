#!/bin/bash

BWHITE='\033[1m' # bold white
NC='\033[0m' # No Color

totaltime=${1:-60}

# time display mode can be: "hide" or "display"
mode=${3:-display}

printf "\n\t${BWHITE}starting timer\n\n\tducking in $totaltime minutes ...\n\n"

for (( time=1; time<=$totaltime; time++ )) do
	sleep 60
	if [[ $mode == "display" ]] && [[ $(($time % 300)) == 0 ]]; then
		# echo -e "\e[1m$time minutes"
		echo -e "\t\t$time minutes"
	fi
done
echo -e "\n\tend of the time\n"

mpv ${2:-/usr/share/sounds/timer/duck.wav > /dev/null 2>&1 &}

echo -e "mpv pid: $$${NC}\n"
