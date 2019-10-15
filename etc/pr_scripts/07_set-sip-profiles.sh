#!/bin/ash

uci set mmpbxrvsipnet.sip_profile_0=profile
uci set mmpbxrvsipnet.sip_profile_0.enabled='1'
uci set mmpbxrvsipnet.sip_profile_0.network='sip_net'
uci set mmpbxrvsipnet.sip_profile_0.user_name='UserName0'
uci set mmpbxrvsipnet.sip_profile_0.display_name='DisplayName0'
uci set mmpbxrvsipnet.sip_profile_0.password='Password0'
uci set mmpbxrvsipnet.sip_profile_0.uri='Uri0'
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
