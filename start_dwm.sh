#! /bin/bash
# status bar 

# battery and time
#FWBATT=0
#SWBATT=0

BATT(){

    #BATT=$(acpi -b | sed 's/.*[charging|unknown], \([0-9]*\)%.*/\1/gi')
    BATT=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)
    if [ $STATUS == "Unknown" ];
        then
            STATUS="Charging"
    fi
    #STATUS=$(acpi -b | sed 's/.*: \([a-zA-Z]*\),.*/\1/gi')

    if [ $BATT -ge 80 ]; then
    echo "  $BATT% $STATUS"
    elif ((51 < $BATT && $BATT < 80)); then
    #elif [ $BATT -ge 70 ]; then
    echo "  $BATT% $STATUS"
    elif [ $BATT -le 51 ] && [ $BATT -gt 30 ]; then
    echo "  $BATT% $STATUS"
    elif [ $BATT -le 30 ] && [ $BATT -ge 10 ]; then
    echo "  $BATT% $STATUS"
    elif [ $BATT -lt 10 ]; then
    echo "  $BATT% $STATUS"
    fi
	
   # if([ $BATT -le 5 ] && [ $STATUS == 'Discharging' ] && [ $SWBATT -eq 0 ]); then
   #     zenity --warning --text 'Too Low Battery, $BATT%.'
   # SWBATT=1
   # fi
   # echo "Batt:$BATT%"
}

Dat(){
    dat=$(date "+%m/%d-%R") # data "+%d/%m/%y %R"
    echo " $dat"
}

Lip(){
    lip=$(ip a | grep wlp3s0 | grep -oE '([[:digit:]].{3}){3}\/[[:digit:]]{2}')
    echo "  $lip"
}

getVolum(){
    #v=$(amixer sget Master | grep -oE '[[:digit:]]{2}%')
    v1=$(amixer sget Master | grep -oE '[[:digit:]]+%.*\[[[:alpha:]]+\]' | sed -e 's/\[//g' -e 's/\]//g' | awk '{printf("%s (%s)",$1,$3)}') #show level+Mute(off/on)
    mic=$(amixer sget 'Capture' | egrep -o '\[[a-zA-Z]+]' -m 1)
    echo " $v1  mic $mic"
}
getBright(){
    actualbr=$(cat /sys/class/backlight/intel_backlight/brightness) #actual_brightness
    maxbr="4437" #$(cat /sys/class/backlight/intel_backlight/max_brightness) no need to calculate, we already knew the max value
    #brightness=$(bc <<< "scale=2;($actualbr / $maxbr) * 100")
    brightness=$(bc <<< "$actualbr * 100 / $maxbr") #$(( ... ))
    echo " bright: $brightness%"
}
while true
do
    #BATT=$(acpi -b | sed 's/.*[charging|unknown], \(0-9)*\)%.*/\1/gi')
     
    xsetroot -name "$(Lip)|$(BATT)|$(getVolum)|$(getBright)|$(Dat)"
    sleep 2m

done &
#pactl set-default-sink 0
setxkbmap -layout us,fr,ar -option grp:ctrls_toggle
setxkbmap -option "ctrl:nocaps"
synclient HorizTwoFingerScroll=1
~/.fehbg &
dwm
#exec ~/.config/dwm/slstatus/slstatus &
