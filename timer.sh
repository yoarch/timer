#!/bin/bash

# RED='\033[0;31m'
BWHITE='\033[1m' # bold white
NC='\033[0m' # No Color

totaltime=${1:-60}

# time display mode can be: "hide" or "display"
mode=${3:-display}

printf "\n\t${BWHITE}starting timer\n\n\tducking in $totaltime minutes ...\n\n"

for (( c=1; c<=$totaltime; c++ )) do
	sleep 60
	time=$c
	if [[ $mode == "display" ]] && [[ $(($time % 5)) == 0 ]]; then
		# echo -e "\e[1m$time minutes"
		printf "$time minutes"
	fi
done


printf "I ${BWHITE}love${NC} Stack Overflow\n"

echo -e "end of the time\n"
# echo -e "\e[1mend of the time\n"

mpv ${2:-$MHOME/dev/inputs/utopia_alarm.mp3 > /dev/null 2>&1 &}

echo "\e[1mmpv pid: $$${NC}"
