#!/bin/bash
#
# Interface changer
# Switchs from HostAPD to wlan0, uses netfaceschanger.py
# Author : Alex Gray
if [ $# = 0 ];then
	echo "***ERROR: Wrong number of arugments passed!"
	echo "-----------------------------------"
	echo "Usage:"
	echo "wlan NETWORK_NAME PASSWORD"
	echo "host"	
	echo "-----------------------------------"
else
	if [ $# = 1 ] && [ $1 = "host" ];
	then
		echo "$(tput setaf 5)**Reconfiguring Network Interfaces**$(tput sgr 0)"
		sudo python netfaceschanger.py host
		echo "$(tput setaf 5)**Attempting to start hostapd**$(tput sgr 0)"
		/etc/init.d/hostapd start
		echo "$(tput setaf 5)**Attempting to strat isc-dhcp-server**$(tput sgr 0)"
		/etc/init.d/isc-dhcp-server start
		echo "$(tput setaf 5)**Attempting to restart robot_web_server.py**$(tput sgr 0)"
		/etc/init.d/robot_web_server stop
		/etc/init.d/robot_web_server start
	elif [ $# = 2 ];
	then
		echo "$(tput setaf 5)**Attempting to stop hostapd**$(tput sgr 0)"
		/etc/init.d/hostapd stop
		echo "$(tput setaf 5)**Attempting to stop isc-dhcp-server**$(tput sgr 0)"
		/etc/init.d/isc-dhcp-server stop
		echo "$(tput setaf 5)**Reconfiguring Network Interfaces**$(tput sgr 0)"
		sudo python netfaceschanger.py wlan $1 $2
		echo "$(tput setaf 5)**Attempting to restart robot_web_server.py**$(tput sgr 0)"
		/etc/init.d/robot_web_server stop
		/etc/init.d/robot_web_server start
	fi

	echo "-----------------------------------"
	echo "          END OF SCRIPT"
	echo "-----------------------------------"
fi
