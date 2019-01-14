#!/bin/sh

set_rules()
{
    echo -e "*filter\n:INPUT DROP [0:0]\n:OUTPUT DROP [0:0]\n:FORWARD DROP [0:0]\n$(cat in-rules.v4 out-rules.v4)" > rules.v4
    echo "COMMIT" >> rules.v4

    cp rules.v4 /etc/iptables/
    chmod 644 /etc/iptables/rules.v4
    chown root:root /etc/iptables/rules.v4

    echo -e "*filter\n:INPUT DROP [0:0]\n:OUTPUT DROP [0:0]\n:FORWARD DROP [0:0]\n" > rules.v6
    echo "COMMIT" >> rules.v6

    cp rules.v6 /etc/iptables/
    chmod 644 /etc/iptables/rules.v6
    chown root:root /etc/iptables/rules.v6
}

clean()
{
    rm *-rules.v4 *-rules.v6
}

set_rules
