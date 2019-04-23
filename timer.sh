#!/bin/bash

function check_args {
	if [ -z $1 ]; then
		echo -e "\n\t${BWHITE}needs at least one argument being the time in minute you want the timer to stop in\n\tfor 2 minutes enter:\n\ttimer 2"
		exit 1
	fi

	if [ "$#" -eq 1 ] && ([[ $1 == "-h" ]] || [[ $1 == "--help" ]]); then
    cat /usr/lib/timer/README.md
		exit 0
	fi

	if ! [[ "$1" =~ ^[0-9]+$ ]]; then
		echo -e "\n\t${BWHITE}first argument must be an integer being the time in minute you want the timer to stop in\n\tfor 2 minutes enter:\n\ttimer 2"
		exit 1
	fi
}

BWHITE='\033[1m' # bold white
NC='\033[0m' # no color

check_args "$@"

totaltime=$1

# time display mode can be: "hide" or "display"
mode=${3:-display}

echo -e "\n\t${BWHITE}starting timer ($(date +"%T"))\n\n\tducking in $totaltime minutes ...\n\n"

for (( time=1; time<=$totaltime; time++ )) do
	sleep 60
	if [[ $mode == "display" ]] && [[ $(($time % 5)) == 0 ]]; then
		echo -e "\t\t$time minutes"
	fi
done
echo -e "\n\tend of the time\n"

audio_path=${2:-"/usr/share/sounds/timer/duck.wav"}
mpv $audio_path > /dev/null 2>&1 &

echo -e "mpv pid: $$${NC}\n"
