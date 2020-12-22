# shell-scripts
A collection of various shell scripts for automation of common tasks


## autoSCP.sh

Tool for automatically copying the contents of a folder to a remote system after connecting to wifi.  
Should be run with a cron-job or other automation so it is always checking for wifi connection.

## install-apps.sh

Script for installing the tools you need for an engagement when you can't bring "hacking tools" with you.

## ipaddr.sh

Lists the IP addresses for each interface.

## list.sh

Gets a list of the files in a directory and displays a count of the number of files.

## menu.sh

Test of the case/switch function for bash shell scripting, with a simple menu for choosing the command to run

## multitool.sh

Mega tool with many different options:

1) Add a user
2) Change your SSH Port
3) Set a static IP.
4) Change your MAC address (WIP).
5) Create a folder.
6) Do a ping sweep of a network.
7) Put a wireless card in monitor/managed mode. (WIP)
8) Monitor wifi. (WIP)
9) Setup a reverse SSH Tunnel. (WIP)
10) Create mangled wordlist. (WIP)
11) Crack passwords with hashcat. (WIP)

## python-fileShare.sh

Creates a Python3 HTTP server, listing the files in the specified directory with ready to copy wget links.
Currently hard-coded for port 8099 
#TODO: take user input for port
