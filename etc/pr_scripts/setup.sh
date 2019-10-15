#!/bin/ash
while true
do
	read -p "Do you want enable serial console & harden root access? [Y/n] " choice01

	case $choice01 in
	    [yY][eE][sS]|[yY]) echo "Enabling serial console & hardening root access";sh /etc/pr_scripts/01_harden-root.sh; break;;
	    [nN][oO]|[nN]) echo "Skipped hardening root access"; break;;
	    *) echo "Please select "yes" or "no"";;
	esac
done

while true
do
	read -p "Do you want to Disable CWMP? [Y/n] " choice02

	case $choice02 in
	    [yY][eE][sS]|[yY]) echo "Disabling CWMP";sh /etc/pr_scripts/02_disable-cwmp.sh; break;;
	    [nN][oO]|[nN]) echo "Skipped Disabling CWMP"; break;;
	    *) echo "Please select "yes" or "no"";;
	esac
done

while true
do
	read -p "Do you want to disable Telstra monitoring? [Y/n] " choice03

	case $choice03 in
	    [yY][eE][sS]|[yY]) echo "Disabling Telstra monitoring";sh /etc/pr_scripts/03_disable-telstra-monitoring.sh; break;;
	    [nN][oO]|[nN]) echo "Skipped Disabling Telstra monitoring"; break;;
	    *) echo "Please select "yes" or "no"";;
	esac
done

while true
do
	read -p "Do you want to disable Telstra Air/Fon WiFi? [Y/n] " choice04

	case $choice04 in
	    [yY][eE][sS]|[yY]) echo "Disabling Telstra Air/Fon WiFi";sh /etc/pr_scripts/04_disable-telstra-air-fon-wifi.sh; break;;
	    [nN][oO]|[nN]) echo "Skipped Disabling Telstra Air/Fon WiFi"; break;;
	    *) echo "Please select "yes" or "no"";;
	esac
done

while true
do
	read -p "Do you want to disable Telstra access? [Y/n] " choice05

	case $choice05 in
	    [yY][eE][sS]|[yY]) echo "Disabling Telstra monitoring & access";sh /etc/pr_scripts/05_disable-telstra-access.sh; break;;
	    [nN][oO]|[nN]) echo "Skipped Disabling Telstra monitoring"; break;;
	    *) echo "Please select "yes" or "no"";;
	esac
done

while true
do
	read -p "Do you want to unlock the web interface tiles? [Y/n] " choice06

	case $choice06 in
	    [yY][eE][sS]|[yY]) echo "Unlocking web interface tiles";sh /etc/pr_scripts/06_unlock-tiles.sh; break;;
	    [nN][oO]|[nN]) echo "Skipped unlocking web interface tiles"; break;;
	    *) echo "Please select "yes" or "no"";;
	esac
done

while true
do
	read -p "Do you want to fix VOIP & enable multiple SIP accounts? [Y/n] " choice07

	case $choice07 in
	    [yY][eE][sS]|[yY]) echo "Enabling multiple VOIP accounts"; sh /etc/pr_scripts/07_fix-broken-voip.sh; sh /etc/pr_scripts/07_enable-sip-net.sh; sh /etc/pr_scripts/07_set-sip-profiles.sh; break;;
	    [nN][oO]|[nN]) echo "Skipped fixing VOIP"; break;;
	    *) echo "Please select "yes" or "no"";;
	esac
done

while true
do
	read -p "Do you want to enable VOIP while on 4G backup? [Y/n] " choice08

	case $choice08 in
	    [yY][eE][sS]|[yY]) echo "Enabling VOIP on 4G";sh /etc/pr_scripts/08_enable-voip-on-4g.sh; break;;
	    [nN][oO]|[nN]) echo "Skipped enabling VOIP on 4G"; break;;
	    *) echo "Please select "yes" or "no"";;
	esac
done


while true
do
	read -p "Do you want to enable VoLTE backup voice service & SMS reception? [Y/n] " choice09

	case $choice08 in
	    [yY][eE][sS]|[yY]) echo "Enabling VoLTE backup voice & SMS reception";sh /etc/pr_scripts/09_enable-volte-sms.sh; break;;
	    [nN][oO]|[nN]) echo "Skipped enabling VoLTE backup voice & SMS reception"; break;;
	    *) echo "Please select "yes" or "no"";;
	esac
done