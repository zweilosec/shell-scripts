#!/bin/bash

if_function() {

        #list all of the interfaces and print the IPv4 for each one that is up
        iflist=$(ifconfig -l)

        for iface in $iflist
        do 
            ipcheck=$(ifconfig $iface | grep "inet " | cut -d" " -f2)
            if [ -n "$ipcheck" ]
            then 
                echo "The interface is called: $iface and it's IP is:"
                echo $ipcheck
            fi
        done
}


while [ true ]
do
    #Print out menu choices
    echo "What command would you like to run?"
    echo ""
    echo "1) ifconfig"
    echo "2) df -h"
    echo "3) exit"
    echo ""

    #get users choice
    read -p '[1-3]: ' choice

    #depending on user's choice, run the command
    case "$choice" in
    1)
        if_function 
        ;;
    2)
        df -h
        ;;
    3)
        break
        ;;
    esac

done
echo "We are done! Good Bye!"
exit 0
