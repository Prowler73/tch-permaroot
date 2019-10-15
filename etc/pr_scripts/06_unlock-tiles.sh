#!/bin/ash

# Block 2 (Unlocking Web Interface)
uci add_list web.ruleset_main.rules=iproutesmodal
uci set web.iproutesmodal=rule
uci set web.iproutesmodal.target='/modals/iproutes-modal.lp'
uci add_list web.iproutesmodal.roles='admin'
uci add_list web.ruleset_main.rules=systemmodal
uci set web.systemmodal=rule
uci set web.systemmodal.target='/modals/system-modal.lp'
uci add_list web.systemmodal.roles='admin'
uci add_list web.ruleset_main.rules=relaymodal
uci set web.relaymodal=rule
uci set web.relaymodal.target='/modals/relay-modal.lp'
uci add_list web.relaymodal.roles='admin'
uci add_list web.ruleset_main.rules=natalghelpermodal
uci set web.natalghelpermodal=rule
uci set web.natalghelpermodal.target='/modals/nat-alg-helper-modal.lp'
uci add_list web.natalghelpermodal.roles='admin'
uci add_list web.ruleset_main.rules=diagnosticstcpdumpmodal
uci set web.diagnosticstcpdumpmodal=rule
uci set web.diagnosticstcpdumpmodal.target='/modals/diagnostics-tcpdump-modal.lp'
uci add_list web.diagnosticstcpdumpmodal.roles='admin'
sed -e 's/session:hasAccess("\/modals\/diagnostics-network-modal.lp")/session:hasAccess("\/modals\/diagnostics-network-modal.lp") and \n session:hasAccess("\/modals\/diagnostics-tcpdump-modal.lp")/' -i /www/cards/009_diagnostics.lp
sed -e 's^alt="network"></div></td></tr>\\^alt="network"></div></td>\\\n <td><div data-toggle="modal" data-remote="modals/diagnostics-tcpdump-modal.lp" data-id="diagnostics-tcpdump-modal"><img href="#" rel="tooltip" data-original-title="TCPDUMP" src="/img/network_sans-32.png" alt="network"></div></td></tr>\\^' -i /www/cards/009_diagnostics.lp
sed -e 's/{"logviewer-modal.lp", T"Log viewer"},/{"logviewer-modal.lp", T"Log viewer"},\n {"diagnostics-tcpdump-modal.lp", T"tcpdump"},\n/' -i /www/snippets/tabs-diagnostics.lp
sed -e 's/if currentuserrole == "guest" /if currentuserrole == "admin" /' -i /www/docroot/modals/gateway-modal.lp
uci commit
# Unlock Tiles & add Selections
uci add_list web.ruleset_main.rules=xdsllowmodal
uci set web.xdsllowmodal=rule
uci set web.xdsllowmodal.target='/modals/xdsl-low-modal.lp'
uci add_list web.xdsllowmodal.roles='admin'
uci commit
# Enable Unsigned config export and Firmware upgrade in Web GUI
uci set system.config.export_plaintext='1'
uci set system.config.export_unsigned='1'
uci set system.config.import_plaintext='1'
uci set system.config.import_unsigned='1'
uci set web.uidefault.upgradefw_role='admin'
uci add_list web.parentalblock.roles='admin'
uci commit
