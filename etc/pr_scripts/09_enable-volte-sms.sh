#!/bin/ash

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
uci commit
/etc/init.d/nginx restart
/etc/init.d/mmpbxd restart
