#!/bin/ash

# Remove any ISP ssh access pubkey
echo > /etc/dropbear/authorized_keys
# Completely disable SSH access over wan
uci set dropbear.wan.enable='0'
uci commit
# Free space for gateways with small flash
opkg --force-removal-of-dependent-packages remove conf-cwmpd cwmpd autoreset-tch mappings-fon geolocation-tch
find /rom/usr/lib/ipk -type f |xargs -n1 basename | cut -f 1 -d '_' |xargs opkg --force-removal-of-dependent-packages remove
