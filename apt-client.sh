#!/bin/sh

set_firewall_rules()
{
    echo "-N IN_APT_CLIENT" >> in-rules.v4
    echo "-A INPUT         -p tcp -m multiport --sports 80,443 -m multiport --dports 1024:65535 -j IN_APT_CLIENT" >> in-rules.v4
    echo "-A IN_APT_CLIENT -p tcp --sport 80  -m state --state ESTABLISHED -j ACCEPT" >> in-rules.v4
    echo "-A IN_APT_CLIENT -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT" >> in-rules.v4
    echo "-A IN_APT_CLIENT -j DROP" >> in-rules.v4

    echo "-N OUT_APT_CLIENT" >> out-rules.v4
    echo "-A OUTPUT         -p tcp -m multiport --sports 1024:65535 -m multiport --dports 80,443 -j OUT_APT_CLIENT" >> out-rules.v4
    echo "-A OUT_APT_CLIENT -p tcp --dport 80  -m state --state NEW,ESTABLISHED -j ACCEPT" >> out-rules.v4
    echo "-A OUT_APT_CLIENT -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT" >> out-rules.v4
    echo "-A OUT_APT_CLIENT -j DROP" >> out-rules.v4
}

set_firewall_rules
