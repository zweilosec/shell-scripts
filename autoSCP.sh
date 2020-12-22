#!/bin/sh

#meant to be used in a cron job to upload all files in a specific folder when the system connects to a wireless network

# redirect all output into a logfile
exec 1>> /home/pi/test.log 2>&1

#TODO:Add ability for user to specify folders & IP & port & username
PORT=22
IP='10.10.10.10'
localFolder='./'
remoteFolder='/'
USER='kali'

case "$1" in
wlan0)
    case "$2" in
    CONNECTED)
        # do stuff on connect with wlan0
        echo wlan0 connected
	    # copy all files to remote system with SCP
	    scp -rP $PORT $localFolder $USER@$IP:$remoteFolder
	    #turn wireless off after successful transfer?
        ;;
    DISCONNECTED)
        # do stuff on disconnect with wlan0
        echo wlan0 disconnected
#	    sudo motion stop
#	    sudo service motion stop
        ;;
    *)
        >&2 echo empty or undefined event for wlan0: "$2"
        exit 1
        ;;
    esac
    ;;

wlan1)
    case "$2" in
    CONNECTED)
        # do stuff on connect with wlan1
        echo wlan1 connected
        ;;
    DISCONNECTED)
        # do stuff on disconnect with wlan1
        echo wlan1 disconnected
        ;;
    *)
        >&2 echo empty or undefined event for wlan1: "$2"
        exit 1
