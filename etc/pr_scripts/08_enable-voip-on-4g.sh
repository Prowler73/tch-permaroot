#!/bin/ash

# Enable VOIP while on backup
uci set mmpbxrvsipnet.sip_net.interface='lan'
uci set mmpbxrvsipnet.sip_net.interface6='lan6'
uci set mmpbxrvsipnet.sip_net_1.interface='lan'
uci set mmpbxrvsipnet.sip_net_1.interface6='lan6'
uci commit
/etc/init.d/nginx restart
/etc/init.d/mmpbxd restart
 