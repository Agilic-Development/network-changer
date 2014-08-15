#!usr/bin/python
import sys
import subprocess

def write_wlan0(network, password):
    f = open('/etc/network/interfaces', 'w')
    f.write('#File written using network-interfaces-changer\n')
    f.write('auto lo\n')
    f.write('\n')
    f.write('iface lo inet loopback\n')
    f.write('iface eth0 inet dhcp')
    f.write('\n')
    f.write('allow-hotplug wlan0\n')
    f.write('auto wlan0\n')
    f.write('\n')
    f.write('\n')
    f.write('iface wlan0 inet dhcp\n')
    f.write('wpa-ssid "%s"\n' %network)
    f.write('wpa-psk "%s"\n' %password)
    f.close()

def write_host():
    f = open('/etc/network/interfaces', 'w')
    f.write('#File written using network-interfaces-changer\n')
    f.write('auto lo\n')
    f.write('\n')
    f.write('iface lo inet loopback\n')
    f.write('iface eth0 inet dhcp\n')
    f.write('\n')
    f.write('allow-hotplug wlan0\n')
    f.write('\n')
    f.write('iface wlan0 inet static\n')
    f.write('\n')
    f.write('        address 192.168.42.1\n')
    f.write('        netmask 255.255.255.0\n')
    f.close()


if len(sys.argv) == 2:
    if sys.argv[1] == 'host':
        write_host()
        subprocess.call("sudo service networking restart", shell=True)
        print("host is written to 'etc/network/interfaces'")
    else:
        print("Unknown argument!")
elif len(sys.argv) == 4:
    if sys.argv[1] == 'wlan':
        write_wlan0(sys.argv[2], sys.argv[3])
        subprocess.call("sudo service networking restart", shell=True)
        print("wlan0 is written to 'etc/network/interfaces'")

else:
    print("Wrong number of arguments passed!")
    print("Please select a interface to use; 'wlan' or 'host'")
