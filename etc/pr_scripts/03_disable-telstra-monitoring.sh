#!/bin/ash

# Disable Telstra monitoring
uci delete tls-vsparc.Config
uci delete tls-vsparc.Passive
uci delete autoreset.vsparc_enabled
uci delete autoreset.thor_enabled
uci delete wifi_doctor_agent.acs
uci delete wifi_doctor_agent.config
uci delete wifi_doctor_agent.as_config
uci commit
