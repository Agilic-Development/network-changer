#!/bin/bash
#
# Interface changer
# Switchs from HostAPD to wlan0, uses netfaceschanger.py
# Author : Alex Gray
if [ $# = 0 ];then
	echo "ERROR: Wrong arugments passed!"
	echo "-----------------------------------"
	echo "Usage:"
	echo "wlan NETWORK_NAME PASSWORD"
	echo "host"	
	echo "-----------------------------------"
else
	if [ $# = 1 ] && [ $1 = "host" ];
	then
		echo "Reconfiguring Network Interfaces"
		python netfaceschanger.py host
		echo "Attempting to start hostapd"
		/etc/init.d/hostapd start
		echo "Attempting to strat isc-dhcp-server"
		/etc/init.d/isc-dhcp-server start
		echo "Attempting to restart robot_web_server.py"
		/etc/init.d/robot_web_server restart
	elif [ $# = 2 ];
	then
		echo "Attempting to stop hostapd"
		/etc/init.d/hostapd stop
		echo "Attempting to stop isc-dhcp-server"
		/etc/init.d/isc-dhcp-server stop
		echo "Reconfiguring Network Interfaces"
		python netfaceschanger.py wlan $1 $2
		echo "Attempting to restart robot_web_server.py"
		/etc/init.d/robot_web_server restart
	fi

	echo "-----------------------------------"
	echo "          END OF SCRIPT"
	echo "-----------------------------------"
fi
