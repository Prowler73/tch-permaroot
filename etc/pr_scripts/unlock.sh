#!/bin/sh
. /etc/init.d/rootdevice

# Block 1 (Hardening Root & Disabling Telstra Access)
# Enable Serial Console
sed -i 's/#//' /etc/inittab
# Enable Permanent SSH
uci add dropbear dropbear
uci rename dropbear.@dropbear[-1]=afg
uci set dropbear.afg.enable='1'
uci set dropbear.afg.Interface='lan'
uci set dropbear.afg.Port='22'
uci set dropbear.afg.IdleTimeout='600'
uci set dropbear.afg.PasswordAuth='on'
uci set dropbear.afg.RootPasswordAuth='on'
uci set dropbear.afg.RootLogin='1'
uci commit dropbear
uci set dropbear.wan=dropbear
uci set dropbear.wan.PasswordAuth='off'
uci set dropbear.wan.RootPasswordAuth='on'
uci set dropbear.wan.Port='22'
uci set ropbear.wan.Interface='wan'
uci set dropbear.wan.AllowedClientIPs='wanip'
uci set dropbear.wan.IdleTimeout='3600'
uci set dropbear.wan.enable='1'
uci set dropbear.lan=dropbear
uci set ropbear.lan.PasswordAuth='on'
uci set dropbear.lan.RootPasswordAuth='on'
uci set dropbear.lan.Interface='lan'
uci set dropbear.lan.enable='1'
uci set dropbear.lan.IdleTimeout='3600'
uci set dropbear.lan.Port='22'
uci set clash.main_config=single_config
uci set clash.main_config.module_path='/usr/lib/lua/clash/modules'
uci set clash.main_config.log_level='3'
uci set clash.engineer=user
uci set clash.engineer.ssh='1'
uci set clash.engineer.telnet='1'
uci set clash.engineer.serial='1'
uci set clash.engineer.ssh_key='prowler'
uci set web.uidefault.upgradefw_role='admin'
/etc/init.d/dropbear restart; uci commit; exit
/etc/init.d/dropbear enable
/etc/init.d/dropbear restart
# Disable CWMP
uci delete cwmpd.cwmpd_config
uci delete firewall.cwmpd
uci del_list watchdog.@watchdog[0].pidfile='/var/run/cwmpd.pid'
uci del_list watchdog.@watchdog[0].pidfile='/var/run/cwmpevents.pid'
uci commit
/etc/init.d/watchdog-tch reload
/etc/init.d/cwmpd disable
/etc/init.d/cwmpd stop
/etc/init.d/cwmpdboot disable
/etc/init.d/cwmpdboot stop
/etc/init.d/zkernelpanic disable
/etc/init.d/zkernelpanic stop
uci set cwmpd.cwmpd_config.state=0
uci set cwmpd.cwmpd_config.acs_url='https://127.0.1.1:7547/'
uci set cwmpd.cwmpd_config.use_dhcp=0
uci set cwmpd.cwmpd_config.interface=loopback
uci set cwmpd.cwmpd_config.enforce_https=1
uci commit cwmpd
# Disable Telstra monitoring
uci delete tls-vsparc.Config
uci delete tls-vsparc.Passive
uci delete autoreset.vsparc_enabled
uci delete autoreset.thor_enabled
uci delete wifi_doctor_agent.acs
uci delete wifi_doctor_agent.config
uci delete wifi_doctor_agent.as_config
uci commit
# Disable Telstra Air/Fon WiFi
/etc/init.d/hotspotd stop
/etc/init.d/hotspotd disable
uci delete dhcp.hotspot
uci delete dhcp.fonopen
uci commit
# Remove any ISP ssh access pubkey
echo > /etc/dropbear/authorized_keys
# Completely disable SSH access over wan
uci set dropbear.wan.enable='0'
uci commit
# Free space for gateways with small flash
opkg --force-removal-of-dependent-packages remove conf-cwmpd cwmpd autoreset-tch mappings-fon geolocation-tch
find /rom/usr/lib/ipk -type f |xargs -n1 basename | cut -f 1 -d '_' |xargs opkg --force-removal-of-dependent-packages remove

# Unlock Tiles & add Selections




#Rules
uci add_list web.uidefault.upgradefw_role='admin'
uci set web.natalghelpermodal=rule
uci set web.relaymodal=rule
uci set web.systemmodal=rule
uci set web.iproutesmodal=rule
uci set web.mmpbxinoutgoingmapmodal=rule
uci set web.mmpbxstatisticsmodal=rule
uci set web.ltedoctor=rule
uci set web.ltemodal=rule
uci set web.lteprofiles=rule
uci set web.ltesim=rule
uci set web.ltesms=rule
uci set web.logconnections=rule
uci set web.logviewer=rule
uci set web.logviewer.roles=rule
uci set web.diagnosticstcpdumpmodal=rule
uci set tod.global.enabled='1'
uci set mobiled.globals.enabled='1'
uci set mobiled.device_defaults.enabled='1'
uci commit; /etc/init.d/nginx restart

#Ruleset
uci add_list web.ruleset_main.rules=xdsllowmodal
uci add_list web.ruleset_main.rules=systemmodal
uci add_list web.ruleset_main.rules=natalghelpermodal
uci add_list web.ruleset_main.rules=diagnostics
uci add_list web.ruleset_main.rules=diagnosticstcpdumpmodal
uci add_list web.ruleset_main.rules=basicviewaccesscodemodal
uci add_list web.ruleset_main.rules=basicviewwifiguestmodal
uci add_list web.ruleset_main.rules=basicviewwifiguest5GHzmodal
uci add_list web.ruleset_main.rules=basicviewwifipskmodal
uci add_list web.ruleset_main.rules=basicviewwifipsk5GHzmodal
uci add_list web.ruleset_main.rules=basicviewwifissidmodal
uci add_list web.ruleset_main.rules=basicviewwifissid5GHzmodal
uci add_list web.ruleset_main.rules=relaymodal
uci add_list web.ruleset_main.rules=iproutesmodal
uci add_list web.ruleset_main.rules=mmpbxinoutgoingmapmodal
uci add_list web.ruleset_main.rules=mmpbxstatisticsmodal
uci commit; /etc/init.d/nginx restart

#Target ( You will get even more stuff in webinterface after you run below commands )
uci set web.mmpbxinoutgoingmapmodal.target='/modals/mmpbx-inoutgoingmap-modal.lp'
uci set web.iproutesmodal.target='/modals/iproutes-modal.lp'
uci set web.systemmodal.target='/modals/system-modal.lp'
uci set web.relaymodal.target='/modals/relay-modal.lp'
uci set web.natalghelpermodal.target='/modals/nat-alg-helper-modal.lp'
uci set web.diagnosticstcpdumpmodal.target='/modals/diagnostics-tcpdump-modal.lp'
uci set web.natalghelpermodal.target='/modals/basicview-accesscode-modal.lp'
uci set web.natalghelpermodal.target='/modals/basicview-wifiguest-modal.lp'
uci set web.natalghelpermodal.target='/modals/basicview-wifiguest5GHz-modal.lp'
uci set web.natalghelpermodal.target='/modals/basicview-wifipsk-modal.lp'
uci set web.natalghelpermodal.target='/modals/basicview-wifipsk5GHz-modal.lp'
uci set web.natalghelpermodal.target='/modals/basicview-wifissid-modal.lp'
uci set web.natalghelpermodal.target='/modals/basicview-wifissid5GHz-modal.lp'
uci set web.ltemodal.target='/modals/lte-modal.lp'
uci set web.ltedoctor.target='/modals/lte-doctor.lp'
uci set web.lteprofiles.target='/modals/lte-profiles.lp'
uci set web.logconnections.target='/modals/log-connections-modal.lp'
uci set web.logviewer.target='/modals/logviewer-modal.lp'
uci set web.ltesms.target='/modals/lte-sms.lp'
uci set web.ltesim.target='/modals/lte-sim.lp'
uci set web.xdsllowmodal.target='/modals/xdsl-low-modal.lp'
uci set web.mmpbxstatisticsmodal.target='/modals/mmpbx-statistics-modal.lp'
uci commit; /etc/init.d/nginx restart

#Roles ( You will see new stuff on webinterface after you run below commands)
uci add_list web.assistancemodal.roles='admin'
uci add_list web.usermgrmodal.roles='admin'
uci add_list web.cwmpconf.roles='admin'
uci add_list web.todmodal.roles='admin'
uci add_list web.iproutesmodal.roles='admin'
uci add_list web.natalghelper.roles='admin'
uci add_list web.mmpbxglobalmodal.roles='admin'
uci add_list web.mmpbxprofilemodal.roles='admin'
uci add_list web.parentalblock.roles=admin
uci add_list web.mmpbxinoutgoingmapmodal.roles='admin'
uci add_list web.systemmodal.roles='admin'
uci add_list web.relaymodal.roles='admin'
uci add_list web.natalghelpermodal.roles='admin'
uci add_list web.diagnosticstcpdumpmodal.roles='admin'
uci add_list web.ltedoctor.roles='admin'
uci add_list web.ltemodal.roles='admin'
uci add_list web.lteprofiles.roles='admin'
uci add_list web.xdsllowmodal.roles='admin'
uci add_list web.ltesim.roles='admin'
uci add_list web.logconnections.roles='admin'
uci add_list web.logviewer.roles='admin'
uci add_list web.logconnections.roles='admin'
uci add_list web.home.roles='admin'
uci add_list web.ltesms.roles='admin'
uci add_list web.logviewer.roles='admin'
uci add_list web.tvoicecontacts.roles='admin'
uci add_list web.tvoicecalllog.roles='admin'
uci add_list web.tvoicecapability.roles='admin'
uci add_list web.tvoicesipconfig.roles='admin'
uci add_list web.mmpbxstatisticsmodal.roles='admin'
uci commit; /etc/init.d/nginx restart
sed -e 's/session:hasAccess("\/modals\/diagnostics-network-modal.lp")/session:hasAccess("\/modals\/diagnostics-network-modal.lp") and \n session:hasAccess("\/modals\/diagnostics-tcpdump-modal.lp")/' -i /www/cards/009_diagnostics.lp
sed -e 's^alt="network"></div></td></tr>\\^alt="network"></div></td>\\\n <td><div data-toggle="modal" data-remote="modals/diagnostics-tcpdump-modal.lp" data-id="diagnostics-tcpdump-modal"><img href="#" rel="tooltip" data-original-title="TCPDUMP" src="/img/network_sans-32.png" alt="network"></div></td></tr>\\^' -i /www/cards/009_diagnostics.lp
sed -e 's/{"logviewer-modal.lp", T"Log viewer"},/{"logviewer-modal.lp", T"Log viewer"},\n {"diagnostics-tcpdump-modal.lp", T"tcpdump"},\n/' -i /www/snippets/tabs-diagnostics.lp
sed -e 's/if currentuserrole == "guest" /if currentuserrole == "admin" /' -i /www/docroot/modals/gateway-modal.lp
uci commit

# Enable Unsigned config export and Firmware upgrade in Web GUI
uci set system.config.export_plaintext='1'
uci set system.config.export_unsigned='1'
uci set system.config.import_plaintext='1'
uci set system.config.import_unsigned='1'
uci set web.uidefault.upgradefw_role='admin'
uci add_list web.parentalblock.roles='admin'
uci commit

# Block 3 (Setting VOIP)
uci set mmpbxrvsipnet.sip_profile_0=profile
uci set mmpbxrvsipnet.sip_profile_0.enabled='1'
uci set mmpbxrvsipnet.sip_profile_0.network='sip_net'
uci set mmpbxrvsipnet.sip_profile_0.user_name='UserName0'
uci set mmpbxrvsipnet.sip_profile_0.display_name='DisplayName0'
uci set mmpbxrvsipnet.sip_profile_0.password='Password0'
uci set mmpbxrvsipnet.sip_profile_0.uri='Uri0'
uci set mmpbxrvsipnet.sip_net.primary_proxy='primary.proxy.0'
uci set mmpbxrvsipnet.sip_net.user_friendly_name='SIP Network 0'
uci set mmpbxrvsipnet.sip_net.local_port='5070'
uci set mmpbxrvsipnet.sip_net.primary_registrar='primary.registrar.0'
uci set mmpbxrvsipnet.sip_net.primary_proxy_port='5060'
uci set mmpbxrvsipnet.sip_net.reg_expire='3600'
uci set mmpbxrvsipnet.sip_net.primary_registrar_port='5060'
uci set mmpbxrvsipnet.sip_profile_0.enabled='1'
uci set mmpbxbrcmfxsdev.fxs_dev_0.relay_state='1'
uci set mmpbxbrcmfxsdev.fxs_dev_1.relay_state='1'
uci set mmpbxrvsipnet.sip_profile_1.enabled='1'
uci set mmpbxbrcmfxsdev.fxs_dev_0.relay_state='1'
uci set mmpbxbrcmfxsdev.fxs_dev_1.relay_state='1'
uci del_list mmpbx.@outgoing_map[0].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[0].priority='2'
uci del_list mmpbx.@outgoing_map[1].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[1].priority='2'
uci del_list mmpbx.@outgoing_map[2].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[2].priority='2'
uci del_list mmpbx.@outgoing_map[3].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[3].priority='2'
uci del_list mmpbx.@outgoing_map[4].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[4].priority='2'
uci del_list mmpbx.@outgoing_map[5].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[5].priority='2'
uci del_list mmpbx.@outgoing_map[6].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[6].priority='2'
uci del_list mmpbx.@outgoing_map[7].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[7].priority='2'
uci del_list mmpbx.@outgoing_map[8].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[8].priority='2'
uci del_list mmpbx.@outgoing_map[9].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[9].priority='2'
uci del_list mmpbx.@outgoing_map[10].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[10].priority='2'
uci del_list mmpbx.@outgoing_map[11].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[11].priority='2'
uci del_list mmpbx.@outgoing_map[12].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[12].priority='2'
uci del_list mmpbx.@outgoing_map[13].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[13].priority='2'
uci del_list mmpbx.@outgoing_map[14].profile='fxo_profile'
uci del_list mmpbx.@outgoing_map[14].priority='2'
sed -e 's/getrole()=="guest"/getrole()=="admin"/' -i /www/snippets/tabs-voice.lp
uci commit
uci set mmpbxrvsipdev.sip_dev_0.password=`dd if=/dev/urandom bs=1 | tr -dc A-Za-z0-9 | head -c${1:-10}`
uci set mmpbxrvsipdev.sip_dev_1.password=`dd if=/dev/urandom bs=1 | tr -dc A-Za-z0-9 | head -c${1:-10}`
uci set mmpbxrvsipdev.sip_dev_2.password=`dd if=/dev/urandom bs=1 | tr -dc A-Za-z0-9 | head -c${1:-10}`
uci set mmpbxrvsipdev.sip_dev_3.password=`dd if=/dev/urandom bs=1 | tr -dc A-Za-z0-9 | head -c${1:-10}`
uci set mmpbxrvsipdev.sip_dev_4.password=`dd if=/dev/urandom bs=1 | tr -dc A-Za-z0-9 | head -c${1:-10}`
uci set mmpbxrvsipdev.sip_dev_5.password=`dd if=/dev/urandom bs=1 | tr -dc A-Za-z0-9 | head -c${1:-10}`
uci set mmpbxrvsipdev.sip_dev_6.password=`dd if=/dev/urandom bs=1 | tr -dc A-Za-z0-9 | head -c${1:-10}`
uci set mmpbxrvsipdev.sip_dev_0.push_type='none'
uci set mmpbxrvsipdev.sip_dev_1.push_type='none'
uci set mmpbxrvsipdev.sip_dev_2.push_type='none'
uci set mmpbxrvsipdev.sip_dev_3.push_type='none'
uci set mmpbxrvsipdev.sip_dev_4.push_type='none'
uci set mmpbxrvsipdev.sip_dev_5.push_type='none'
uci set mmpbxrvsipdev.sip_dev_6.push_type='none'
uci delete mmpbxrvsipdev.sip_server.apn_cert_key
uci delete mmpbxrvsipdev.sip_server.apn_interface
sed -e 's/{"mmpbx-sipdevice-modal.lp", T"Sip Device"},/{"mmpbx-sipdevice-modal.lp", T"Sip Device"},\n{"mmpbx-inoutgoingmap-modal.lp", T"In-Out Mapping"},\n{"mmpbx-statistics-modal.lp", T"Statistics"},/' -i /www/snippets/tabs-voice.lp
uci commit
 
# Block 3B (Optional: Adding 2nd SIP Provider)
uci set mmpbx.sip_net_1=network
uci set mmpbx.sip_net_1.config='uci set mmpbxrvsipnet'
uci commit
uci set mmpbxrvsipnet.sip_net_1=network
uci set mmpbxrvsipnet.sip_net_1.session_expires='180'
uci set mmpbxrvsipnet.sip_net_1.no_answer_response='480'
uci set mmpbxrvsipnet.sip_net_1.dtmf_relay_translation='0'
uci set mmpbxrvsipnet.sip_net_1.call_waiting_reject_response='486'
uci set mmpbxrvsipnet.sip_net_1.cac='-1'
uci set mmpbxrvsipnet.sip_net_1.ingress_media_timeout='1000'
uci set mmpbxrvsipnet.sip_net_1.timer_D='50000'
uci set mmpbxrvsipnet.sip_net_1.privacy_handling='apply'
uci set mmpbxrvsipnet.sip_net_1.timer_J='32000'
uci set mmpbxrvsipnet.sip_net_1.reliable_provisional_response='supported'
uci set mmpbxrvsipnet.sip_net_1.transparent_soc_transmission='0'
uci set mmpbxrvsipnet.sip_net_1.switch_back_to_primary_proxy_timer='0'
uci set mmpbxrvsipnet.sip_net_1.transport_type='UDP'
uci set mmpbxrvsipnet.sip_net_1.control_qos_field='dscp'
uci set mmpbxrvsipnet.sip_net_1.timer_T4='5000'
uci set mmpbxrvsipnet.sip_net_1.realtime_qos_field='dscp'
uci set mmpbxrvsipnet.sip_net_1.escape_hash='1'
uci set mmpbxrvsipnet.sip_net_1.dtmf_relay='auto'
uci set mmpbxrvsipnet.sip_net_1.realtime_qos_value='af42'
uci set mmpbxrvsipnet.sip_net_1.fail_behaviour='stop'
uci set mmpbxrvsipnet.sip_net_1.escape_star='0'
uci set mmpbxrvsipnet.sip_net_1.timer_F='32000'
uci set mmpbxrvsipnet.sip_net_1.primary_proxy_port='5060'
uci set mmpbxrvsipnet.sip_net_1.realm_check='0'
uci set mmpbxrvsipnet.sip_net_1.reg_expire='3600'
uci set mmpbxrvsipnet.sip_net_1.reg_back_off_timeout='180'
uci set mmpbxrvsipnet.sip_net_1.secondary_proxy_port='0'
uci set mmpbxrvsipnet.sip_net_1.timer_B='32000'
uci set mmpbxrvsipnet.sip_net_1.uri_clir_format='standard'
uci set mmpbxrvsipnet.sip_net_1.reg_expire_T_before='1'
uci set mmpbxrvsipnet.sip_net_1.re_registration_mode='standard'
uci set mmpbxrvsipnet.sip_net_1.timer_T1='500'
uci set mmpbxrvsipnet.sip_net_1.call_waiting_provisional_response='182'
uci set mmpbxrvsipnet.sip_net_1.forking_mode='default'
uci set mmpbxrvsipnet.sip_net_1.interface='wan'
uci set mmpbxrvsipnet.sip_net_1.session_timer='enabled'
uci set mmpbxrvsipnet.sip_net_1.control_qos_value='ef'
uci set mmpbxrvsipnet.sip_net_1.secondary_registrar_port='5060'
uci set mmpbxrvsipnet.sip_net_1.min_period_proxy_redundancy='0'
uci set mmpbxrvsipnet.sip_net_1.min_session_expires='90'
uci set mmpbxrvsipnet.sip_net_1.primary_registrar_port='5060'
uci set mmpbxrvsipnet.sip_net_1.timer_T2='4000'
uci set mmpbxrvsipnet.sip_net_1.rport_in_via='1'
uci set mmpbxrvsipnet.sip_net_1.provisional_timer='180'
uci set mmpbxrvsipnet.sip_net_1.rejection_response='486'
uci commit
uci set mmpbxrvsipnet.sip_net_1.primary_proxy='primary.proxy.1'
uci set mmpbxrvsipnet.sip_net_1.user_friendly_name='SIP Network 1'
uci set mmpbxrvsipnet.sip_net_1.local_port='5071'
uci set mmpbxrvsipnet.sip_net_1.primary_registrar='primary.registrar.1'
uci set mmpbxrvsipnet.sip_net_1.domain_name='domain.name.1'
uci commit
# SIP Account defaults
uci set mmpbxrvsipnet.sip_profile_1=profile
uci set mmpbxrvsipnet.sip_profile_1.enabled='1'
uci set mmpbxrvsipnet.sip_profile_1.network='sip_net_1'
uci set mmpbxrvsipnet.sip_profile_1.user_name='UserName1'
uci set mmpbxrvsipnet.sip_profile_1.display_name='DisplayName1'
uci set mmpbxrvsipnet.sip_profile_1.password='Password1'
uci set mmpbxrvsipnet.sip_profile_1.uri='Uri1'
uci set mmpbxrvsipnet.sip_profile_2=profile
uci set mmpbxrvsipnet.sip_profile_2.enabled='1'
uci set mmpbxrvsipnet.sip_profile_2.network='sip_net'
uci set mmpbxrvsipnet.sip_profile_2.user_name='UserName2'
uci set mmpbxrvsipnet.sip_profile_2.display_name='DisplayName2'
uci set mmpbxrvsipnet.sip_profile_2.password='Password2'
uci set mmpbxrvsipnet.sip_profile_2.uri='Uri2'
uci set mmpbxrvsipnet.sip_profile_3=profile
uci set mmpbxrvsipnet.sip_profile_3.enabled='1'
uci set mmpbxrvsipnet.sip_profile_3.network='sip_net_1'
uci set mmpbxrvsipnet.sip_profile_3.user_name='UserName3'
uci set mmpbxrvsipnet.sip_profile_3.display_name='DisplayName3'
uci set mmpbxrvsipnet.sip_profile_3.password='Password3'
uci set mmpbxrvsipnet.sip_profile_3.uri='Uri3'
uci commit

# Block 4 (Optional for Gateways with 4G Backup)
# Enable VoLTE backup voice service & SMS reception
uci set mmpbxmobilenet.mobile_profile_0.enabled='1'
uci set mobiled_device_specific.@device[0].ims_pdn_autobringup='1'
uci set mobiled_sessions.@session[0].activated='1'
uci set mobiled_sessions.@session[0].autoconnect='1'
uci set mobiled_sessions.@session[0].optional='1'
uci add_list web.ruleset_main.rules=ltesms
uci set web.ltesms=rule
uci set web.ltesms.target='/modals/lte-sms.lp'
uci add_list web.ltesms.roles='admin'
# Enable VOIP while on backup
uci set mmpbxrvsipnet.sip_net.interface='lan'
uci set mmpbxrvsipnet.sip_net.interface6='lan6'
uci set mmpbxrvsipnet.sip_net_1.interface='lan'
uci set mmpbxrvsipnet.sip_net_1.interface6='lan6'
uci commit; /etc/init.d/nginx restart
/etc/init.d/mmpbxd restart
 
