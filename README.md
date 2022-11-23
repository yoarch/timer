# timer
Simple CLI timer

A simple terminal timer to set one or regular timers, with customizable audio notifications.

# Installation
```sh
yay -a timer
or
yaourt -a timer
```

# Usage
<pre>
<b>timer</b> [TOTAL_TIME] [TIME_MODE] [TIMERS_NUMBER] [AUDIO_PATH] [DISPLAY_MODE]
<b>options:</b>
    <b>TOTAL_TIME</b>         Must be an integer such as 42
    <b>TIME_MODE</b>          <b>"s"</b> for seconds (default unit), <b>"m"</b> for minutes and <b>"h"</b> for hours
    <b>TIMERS_NUMBER</b>      Number of timers. "1", "1000", <b>"infinity"</b> or <b>"inf"</b> for no limit. 1 by default
    <b>AUDIO_INFO</b>         Either <b>"no_audio"</b> to turn the audio off or an audio file path to play another audio than the default duck one provided
    <b>-h, --help</b>         Show this help message and exit
</pre>


# Examples
For help:<br/>
```sh
timer -h
or
timer --help
```
One timer in 30 seconds
```sh
timer 30
or
timer 30s
or
timer 30 s
or
timer 30 s 1
```
No limit timers every 2 hours with no audio
```sh
timer 2h infinity no_audio
or
timer 2 h inf no_audio
```
5 timers every 50 minutes with specifying another timer audio song
```sh
timer 50m 5 ~/audio/duck_song.mp3
```