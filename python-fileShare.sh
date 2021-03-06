#!/bin/bash

#Makes different colored text
GN="\e[32m"
RES="\e[0m"
CYAN="\e[1;36m"

#font=Big http://www.patorjk.com/software/taag/
echo -e "\n$CYAN""
  _____       _   _                   ______ _ _       _____                          
 |  __ \     | | | |                 |  ____(_) |     / ____|                         
 | |__) |   _| |_| |__   ___  _ __   | |__   _| | ___| (___   ___ _ ____   _____ _ __ 
 |  ___/ | | | __| '_ \ / _ \| '_ \  |  __| | | |/ _ \ ___ \ / _ \ '__\ \ / / _ \ '__|
 | |   | |_| | |_| | | | (_) | | | | | |    | | |  __/____) |  __/ |   \ V /  __/ |   
 |_|    \__, |\__|_| |_|\___/|_| |_| |_|    |_|_|\___|_____/ \___|_|    \_/ \___|_|   
         __/ |                                                                        
        |___/                                                                         
$RES"
echo -e "Created By$GN Ac1d $RES\n"
echo -e "Updated by$CYAN zweilos $RES\n"

#list IPs associated with current hostname
HN="hostname -I"
#put the IPs into a list
res=$(eval $HN)
arrIN=(${res// / })
IP=""
#TODO:Make GetPort function that takes either user input or cmdline argument for custom port
PORT=8099

#if there is more than one IP available, list the first two as options
#TODO: make a way to list all options
if [ ${#arrIN[@]} -gt 1 ]; then
        PS3='Which IP address?: '
        options=("${arrIN[0]}" "${arrIN[1]}" "Quit")
        select opt in "${options[@]}"
        do
        case $opt in
                #Selecting "1" will assign the first IP to $IP
                "${arrIN[0]}")
                        IP="${arrIN[0]}"
                        break
                ;;
                #Selecting "2" will assign the second IP to $IP
                "${arrIN[1]}")
                        IP="${arrIN[1]}"
                        break
                ;;
                #Selecting "3" will exit the program
                "Quit")
                exit 0
                ;;
                
                #Any input other than 1-3 will result in this error message
                *) echo "Invalid option: $REPLY"
                ;;
        esac
        done
else
       IP=$arrIN

fi
echo ""
echo "IP: "$IP
echo ""
echo -e "Download files using these links:\n"
for entry in `ls`;do
        if  [  ! -d $entry  ];then
                wgetCmd=$(echo "wget http://${IP##*( )}:8099/$entry" | xargs)
                echo -e "\t$GN$wgetCmd$RES"
        fi
done
echo ""
echo -e "\nCurrent Directory Contents:"
ls --color .
echo ""
echo -e "\nStarting Server..."

#Opens HTTP Server in the folder the command is run from on port $PORT
python3 -m http.server $PORT -d .
