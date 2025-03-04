#!/bin/ash

# Block 3 (Setting VOIP)
uci set mmpbx.scc_generic.network={'fxo_net','sip_net','sip_net_1'}
uci set mmpbx.dial_plan_generic.network={'internal_net','sip_net','sip_net_1'}
uci set mmpbx.media_filter_audio_sip.network={'sip_net','sip_net_1'}
##uci set mmpbx.dial.network={'DEFAULT_NETWORK','internal_net','sip_net','sip_net_1'}
uci set mmpbx.stutterdial.network={'DEFAULT_NETWORK','internal_net','sip_net','sip_net_1'}
uci set mmpbx.facility.network={'DEFAULT_NETWORK','internal_net','sip_net','sip_net_1','fxo_net'}
uci set mmpbx.ringback.network={'DEFAULT_NETWORK','internal_net','sip_net','sip_net_1'}
uci set mmpbx.busy.network={'DEFAULT_NETWORK','internal_net','sip_net','sip_net_1','builtin_internal_network'}
uci set mmpbx.congestion.network={'DEFAULT_NETWORK','internal_net','sip_net','sip_net_1','builtin_internal_network'}
uci set mmpbx.call_waiting.network={'DEFAULT_NETWORK','internal_net','sip_net','sip_net_1','fxo_net'}
uci set mmpbx.bargein.network={'DEFAULT_NETWORK','internal_net','sip_net','sip_net_1','builtin_internal_network'}
uci set mmpbx.confirmation.network={'DEFAULT_NETWORK','internal_net','sip_net','sip_net_1','fxo_net'}
uci commit
/etc/init.d/nginx restart
/etc/init.d/mmpbxd restart

uci set mmpbx.sip_net_1=network
uci set mmpbx.sip_net_1.config='mmpbxrvsipnet'
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
uci set mmpbxrvsipnet.sip_net_1.primary_proxy='primary.proxy.1'
uci set mmpbxrvsipnet.sip_net_1.user_friendly_name='SIP Network 1'
uci set mmpbxrvsipnet.sip_net_1.local_port='5071'
uci set mmpbxrvsipnet.sip_net_1.primary_registrar='primary.registrar.1'
uci set mmpbxrvsipnet.sip_net_1.domain_name='domain.name.1'
uci commit
/etc/init.d/nginx restart
/etc/init.d/mmpbxd restart
 