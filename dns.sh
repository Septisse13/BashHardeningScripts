#!/bin/sh

set_firewall_rules()
{
    echo "-N IN_DNS_CLIENT" >> in-rules.v4
    echo "-A INPUT         -p udp --sport 53 -m multiport --dports 1024:65535 -j IN_DNS_CLIENT" >> in-rules.v4
    echo "-A IN_DNS_CLIENT -p udp -m state --state ESTABLISHED -j ACCEPT" >> in-rules.v4
    echo "-A IN_DNS_CLIENT -j DROP" >> in-rules.v4

    echo "-N OUT_DNS_CLIENT" >> out-rules.v4
    echo "-A OUTPUT         -p udp --dport 53 -m multiport --sports 1024:65535 -j OUT_DNS_CLIENT" >> out-rules.v4
    echo "-A OUT_DNS_CLIENT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT" >> out-rules.v4
    echo "-A OUT_DNS_CLIENT -j DROP" >> out-rules.v4
}

set_firewall_rules
