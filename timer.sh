#!/bin/bash
message=$1
h=0
m=0
s=0


if [[ $2 == *':'* ]]; then
	IFS=':' read -a time <<< "$2"	

	if [[ ${#time[@]} == 2 ]]; then

	  	m=${time[0]}
	  	s=${time[1]}
	elif [[ ${#time[@]} == 3 ]]; then
	  	h=${time[0]}
	  	m=${time[1]}
	  	s=${time[2]}
	fi	
else
	s=$2
fi


#Save the seconds total
((total=$s+($m*60)+($h*3600)))

for (( i = total; i > 0; i-- )); do
	
	#The time is printed on the screen and in turn the output is redirected to the ".clock" file in the home
	printf "%s: %02d:%02d:%02d" $message $h $m $s | tee $HOME/.clock

	#Wait 1 second
	sleep 1s

	((s=$s-1))
	if [[ $s == '0' && $m > 0 ]]; then
		s='60'
		((m=$m-1 ))
		if [[ $m == '0' && $h > 0 ]]; then
			m='60'
			((h=$h-1))
		fi
	fi

	#the cursor moves to the beginning of the line
	printf "\033[1000D";
done

#Notification
notify-send `basename -- "$0"` $message

#Alarm sound
paplay $HOME/Scripts/complete.oga
echo "" > $HOME/.clock
