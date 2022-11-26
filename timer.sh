#!/bin/bash

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
		exit 1
	fi
}

input_args_as_array=( "$@" )

BWHITE='\033[1m'
BORANGE='\e[1;38;5;202m'
BRED='\e[1;38;5;196m'
NC='\033[0m'

if [ "$#" -eq 1 ] && ([[ $1 == "-h" ]] || [[ $1 == "--help" ]]); then
	cat /usr/lib/timer/README.md
	exit 0
fi

first_argument_error_msg="\n\t${BWHITE}First argument must be either an integer for the number of following time unit or an intenger sticked to a time unit\n\tSuch as:\n\t\ttimer 2\n\t\tor\n\t\ttimer 2 h\n\t\tor\n\t\ttimer 2h${NC}"

if [ -z $1 ]; then
	echo -e "$first_argument_error_msg"
	exit 1
fi

next_argument_to_treat_index=1
if [[ $1 =~ ^[0-9]*[hms]$ ]]; then
	total_time=${1::-1}
	time_mode=${1: -1}
elif [[ $1 =~ ^[0-9]*$ ]]; then
	total_time=$1

	if [[ $2 =~ ^[hms]$ ]]; then
		time_mode=$2
		next_argument_to_treat_index=2
	else
		time_mode="s"
	fi
else
	echo -e "$first_argument_error_msg"
	exit 1
fi

next_arg=${input_args_as_array[$next_argument_to_treat_index]}

if [ -z $next_arg ]; then
	timer_nb=1
	audio_info=""
else
	if [[ $next_arg =~ ^inf.*$ ]]; then
		timer_nb=1000000
		audio_info=${input_args_as_array[$next_argument_to_treat_index+1]}
	elif [[ $next_arg =~ ^[0-9]*$ ]]; then
		timer_nb=$next_arg
		audio_info=${input_args_as_array[$next_argument_to_treat_index+1]}
	elif [[ "$next_arg" == "no_audio" ]] || [ -f "$next_arg" ]; then
		timer_nb=1
		audio_info="$next_arg"
	else
		echo -e "\n\t${BORANGE}[WARNING]${NC} Argument ${BWHITE}$next_arg${NC} is not a known timers number neither an audio file path. Aborting."
		exit 1
	fi
fi

play_audio=true
if [ -z $audio_info ]; then
	audio_path="/usr/share/sounds/timer/duck.wav"
elif [[ "$audio_info" == "no_audio" ]]; then
	play_audio=false
elif [ -f "$audio_info" ]; then
	audio_path="$audio_info"
elif ! [ -f "$audio_info" ]; then
    echo -e "\n\t${BORANGE}[WARNING]${NC} Audio path ${BWHITE}$audio_info${NC} doesn't exist. Setting default audio path ${BWHITE}/usr/share/sounds/timer/duck.wav${NC}"
	audio_path="/usr/share/sounds/timer/duck.wav"
fi

# Display timer settings
if $play_audio ; then
	echo -e "\n\n\tTime between timers: ${BWHITE}$total_time$time_mode${NC}\n\tTimers number: ${BWHITE}$timer_nb${NC}\n\tAudio file: ${BWHITE}$audio_path${NC}"
else
	echo -e "\n\n\tTime between timers: ${BWHITE}$total_time$time_mode${NC}\n\tTimers number: ${BWHITE}$timer_nb${NC}\n\tAudio: ${BWHITE}OFF${NC}"
fi
args_to_scds $total_time $time_mode

# Starting timer message
echo -e "\n\n\t${BWHITE}Starting timer at $(date +"%T")"
if [ "$timer_nb" -eq "1000000" ]; then
	echo -e "\t\tTiming every ${BWHITE}$total_time$time_mode${NC} ...\n"
elif [[ $timer_nb = 1 ]]; then
	echo -e "\t\tTiming in ${BWHITE}$total_time$time_mode${NC} without repetition ...\n"
elif [[ $timer_nb =~ ^[0-9]*$ ]]; then
	echo -e "\t\tTiming every ${BWHITE}$total_time$time_mode .. $timer_nb${NC} times ...\n"
fi

# Starting timer loop
i=0
while ((i<$timer_nb))
do
	sleep $x_seconds
	((i+=1))
	echo -e "\t\t${BWHITE}Timer $i${NC} ($(date +"%T"))"
	if $play_audio ; then
		mpv $audio_path --really-quiet > /dev/null 2>&1 &
	fi
done
