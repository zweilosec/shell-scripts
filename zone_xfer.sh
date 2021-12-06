#!/bin/bash 
#Simple DNS zone transfer brute force script 

#Check if an argument was given. If not, print usage
if [ -z "$1" ]; then
  echo "A Simple DNS zone transfer brute force script"
  echo "[Usage]: $0 <domain_name>"
  echo ""
  exit 0 
fi

#Identify the DNS servers for the given domain 
for server in $(host -t ns $1 | cut -d " " -f4); do 
  #For each DNS server found, attempt a zone transfer 
  host -l $1 $server | grep "has address" 
done 
