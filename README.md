# tch-permaroot
Set of scripts to get permanent root & automated set-up on optimal bank plan for many Technicolor OpenWRT based modem routers
Copyright (C) 2019  Prowler73@gmail.com

These script files were based on & modified from the Custom Gui for Technicolor Modem:
<https://github.com/Ansuel/tch-nginx-gui>.

<h2><strong>Basic installation instructions for the current release:</strong></h2>

<h3><strong> First you need to get initial root access to your Gateway</strong></h3>
	Some useful reference links to help you get initial root access:
<ul>
  https://hack-technicolor.readthedocs.io/en/stable/Hack%20Type%201&2/
	
  https://whirlpool.net.au/wiki/hack_technicolor
	
  https://www.crc.id.au/hacking-the-technicolor-tg799vac-and-unlocking-features/
  
<h3>Then execute these commands (Active WAN/Internet connection required):</h3>

```
curl -L -k https://github.com/Prowler73/tch-permaroot/raw/master/tch-permaroot.tar.bz2 --output /tmp/tch-permaroot.tar.bz2
bzcat /tmp/tch-permaroot.tar.bz2 | tar -C / -xvf -
/etc/init.d/rootdevice force
```
If you get an error during the download process or you have no Internet/WAN connection on the device, just manually download the tch-permaroot.tar.bz2 file and put in /tmp folder via SCP then execute the other (non curl) commands listed above.

