#! /bin/bash
# status bar 

# battery and time
#FWBATT=0
#SWBATT=0

BATT(){

    #BATT=$(acpi -b | sed 's/.*[charging|unknown], \([0-9]*\)%.*/\1/gi')
    BATT=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)
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
    v1=$(amixer sget Master | grep -oE '[[:digit:]]{2}%.*\[[[:alpha:]]+\]' | sed -e 's/\[//g' -e 's/\]//g' | awk '{printf("%s/mic(%s)",$1,$3)}') #show level+mic(off/on)
    echo " $v1"
    }

while true
do
    #BATT=$(acpi -b | sed 's/.*[charging|unknown], \(0-9)*\)%.*/\1/gi')
     
    xsetroot -name "$(Lip)|$(BATT)|$(getVolum)|$(Dat)"
    sleep 2m

done &
#pactl set-default-sink 0
setxkbmap -layout us,fr,ar -option grp:ctrls_toggle
synclient HorizTwoFingerScroll=1
dwm
#exec ~/.config/dwm/slstatus/slstatus &
