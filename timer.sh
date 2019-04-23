#!/bin/bash

function check_args {

	if [ "$#" -eq 1 ] && ([[ $1 == "-h" ]] || [[ $1 == "--help" ]]); then
    cat /usr/lib/timer/README.md
		exit 0
	fi

	if [ -z $2 ]; then
		echo -e "\n\t${BWHITE}needs at least two arguments being the time in timemode\n\tfor 2 minutes enter:\n\ttimer 2 m"
		exit 1
	fi

	if ! [[ "$1" =~ ^[0-9]+$ ]]; then
		echo -e "\n\t${BWHITE}first argument must be an integer being the time in minute you want the timer to stop in\n\tfor 2 minutes enter:\n\ttimer 2"
		exit 1
	fi
}

function args_to_scds {
	x_seconds=0
	if [[ $2 == "h" ]]; then
		x_seconds=$(($1*3600))
	elif [[ $2 == "m" ]]; then
		x_seconds=$(($1*60))
	elif [[ $2 == "s" ]]; then
		x_seconds=$1
	else
		echo -e "$2 arg is not supported, please enter \"h\", \"m\" or \"s\""
		return 1
	fi
}

BWHITE='\033[1m' # bold white
NC='\033[0m' # no color

check_args "$@"

totaltime=$1
# timemode can be "h": hours, "m": minutes, "s": seconds
timemode=$2

# time display mode can be: "hide" or "display"
mode=${4:-display}

args_to_scds $totaltime $timemode

echo -e "\n\t${BWHITE}starting timer ($(date +"%T"))\n\n\tducking in $totaltime$timemode ...\n\n"

i=0
for (( time_s=1; time_s<=$x_seconds; time_s++ )) do
	sleep 1
	if [[ $mode == "display" ]] && [[ $(($time_s % 60)) == 0 ]]; then
		i=$((i+1))
		printf "\n$i: "
		for (( d=1; d<=$i; d++ )) do
			printf "."
		done
	fi
done
echo -e "\n\tend of the time\n"

audio_path=${3:-"/usr/share/sounds/timer/duck.wav"}
mpv $audio_path > /dev/null 2>&1 &

echo -e "mpv pid: $$${NC}\n"
