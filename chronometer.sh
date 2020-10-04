#!/bin/bash
#Wait time
sleep $2 
#Notification
notify-send $1
#Alarm sound
paplay ~/Scripts/complete.oga