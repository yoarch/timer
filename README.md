# timer
a simple timer for terminal

a very simple terminal timer in second, minute or hour, that will play a song and display a message when time is over.

# installation
```sh
yay -a timer
or
yaourt -a timer
```


# usage
<pre>
<b>timer</b> [TOTAL_TIME] [TIME_MODE] [AUDIO_PATH] [DISPLAY_MODE]
<b>options:</b>
<!-- -->         <b>TOTAL_TIME</b>        must be an integer such as 42
<!-- -->         <b>TIME_MODE</b>        "h" for hours, "m" for minutes or "s" for seconds
<!-- -->         <b>AUDIO_PATH</b>        to play another audio than the duck one by default
<!-- -->         <b>DISPLAY_MODE</b>        "hide" or "display": display every minute spent with a dot, enable by default
<!-- -->         <b>-h, --help</b>        show this help message and exit
</pre>


# examples
for help:<br/>
```sh
timer -h
or
timer --help
```
time in 30 seconds
```sh
timer 30 s
```
time in 50 minutes
```sh
timer 50 m ~/audio/duck_song.mp3
```
time in 2 hours
```sh
timer 2 h ~/audio/duck_song.mp3 hide
```
