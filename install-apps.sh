#!/bin/bash

#Intended to be used on non-Kali (Debian) systems if you need access to specific tools
#
# WARNING! - This is dangerous if you install dependencies that overwrite the ones for your specific distro
# make sure to only install programs that minimize dependencies, and disable this source when not
# deliberately installing a program.  WILL definitely break your distro if you run apt upgrade blindly

#---------------------------------------------------------------------------------------------------
#  Add Kali repository to /etc/apt/sources.list                                                   /
#---------------------------------------------------------------------------------------------------

echo deb http://http.kali.org/kali kali-rolling main non-free contrib >> /etc/apt/sources.list

#--------------------------------------------------------------------------------------------------
#  Update sources                                                                                 /
#--------------------------------------------------------------------------------------------------

apt update -y
#apt upgrade -y  <-- DO NOT do this!!

#-------------------------------------------------------------------------------------------------
#  Install kali-specific programs - modify this list as needed                                                                                  /
#-------------------------------------------------------------------------------------------------

apt install -y \
  terminator \
  exiftool \
  hurl \
  veil \
  kali-linux-sdr \
  gpsd gpsd-clients \
