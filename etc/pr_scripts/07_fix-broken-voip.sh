#!/bin/ash

# Block 3 (Setting VOIP)
echo "Ignore some errors - these are normal"
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
uci add_list web.tvoicecontacts.roles=admin
uci add_list web.tvoicecalllog.roles=admin
uci add_list web.tvoicecapability.roles=admin
uci add_list web.tvoicesipconfig.roles=admin
uci add_list web.ruleset_main.rules=mmpbxinoutgoingmapmodal
uci set web.mmpbxinoutgoingmapmodal=rule
uci set web.mmpbxinoutgoingmapmodal.target='/modals/mmpbx-inoutgoingmap-modal.lp'
uci add_list web.mmpbxinoutgoingmapmodal.roles='admin'
uci add_list web.ruleset_main.rules=mmpbxstatisticsmodal
uci set web.mmpbxstatisticsmodal=rule
uci set web.mmpbxstatisticsmodal.target='/modals/mmpbx-statistics-modal.lp'
uci add_list web.mmpbxstatisticsmodal.roles='admin'
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
/etc/init.d/nginx restart
/etc/init.d/mmpbxd restart
 