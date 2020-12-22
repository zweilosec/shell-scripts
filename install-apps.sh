#!/bin/bash

#Intended to be used on non-Kali (Debian) systems if you need access to specific tools

#---------------------------------------------------------------------------------------------------
#  Add Kali repository to /etc/apt/sources.list                                                   /
#---------------------------------------------------------------------------------------------------

echo deb http://http.kali.org/kali kali-rolling main non-free contrib >> /etc/apt/sources.list

#--------------------------------------------------------------------------------------------------
#  Update sources                                                                                 /
#--------------------------------------------------------------------------------------------------

apt update -y
apt upgrade -y

#-------------------------------------------------------------------------------------------------
#  Install apps - modify this list as needed                                                                                  /
#-------------------------------------------------------------------------------------------------

apt install -y \
  terminator \
  ftp \
  exiftool \
  hurl \
  veil \
  kali-linux-sdr \
  gpsd gpsd-clients \
