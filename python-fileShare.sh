#!/bin/bash
# Script for easily sharing files through http, with easy to copy links provided
# Helper functions and optional argument info from http://mywiki.wooledge.org/BashFAQ/035?action=print

#Define ANSI codes for colored text
GN="\e[32m"
RES="\e[0m"
CYAN="\e[1;36m"

echo -e "Created By$GN Ac1d $RES"
echo -e "Updated by$CYAN zweilosec$RES 20FEB2023\n"

# For printing usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-h] [-d DIRECTORY] [-p PORT]
    Share the contents of a directory over HTTP using
    python3 -m http.server.

    -h            display this help and exit
    -d DIRECTORY  directory to share files from
    -p            port to host the server on
EOF
}

die() {
    printf '%s\n' "$1" >&2
    exit 1
}

# Initialize all the option variables.
# This ensures we are not contaminated by variables from the environment.
port=8099
directory="."

while :; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -d|--dir)
            if [[ -d $2 ]]; then
                directory="$2"
                shift
            else
                die 'ERROR: $2 is not a directory!'
            fi
            ;;
        -p|--port)
            port=$2
            shift
            ;;
        *)
            break
    esac

    shift
done

#list IPs associated with current hostname
HN="hostname -I"
#put the IPs into a list
res=$(eval $HN)
arrIN=(${res// / })
IP=""

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
                break
                ;;
                #Any input other than 1-3 will result in this error message
                *) echo "Invalid option: $REPLY";;
        esac
        done
else
    IP=$arrIN

fi
echo ""
echo "IP: "$IP
echo ""
echo -e "Download files using these links:\n"
# For each file in the shared directory, create a wget link
for entry in `ls $directory`;do
        if  [  ! -d $entry  ];then
                wgetCmd=$(echo "wget http://${IP##*( )}:$port/$entry" | xargs)
                echo -e "\t$GN$wgetCmd$RES"
        fi
done
echo ""
echo -e "\nDirectory Contents of $directory"
ls --color $directory
echo ""
echo -e "\nStarting Server"

#Opens HTTP file server from the specified $directory on port $port
python3 -m http.server $port -d $directory
