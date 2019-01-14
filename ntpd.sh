#!/bin/bash

#Documents de référence
# "Recommandations de securite relatives a un systeme GNU/Linux"
# https://www.ssi.gouv.fr/reco-securite-systeme-linux/

set_ntp_conf()
{
    # Création de la prison
    rootdir=/var/chroot/ntp
    mkdir -p ${rootdir}/{etc,var/lib/ntp,var/log}

    # Création du fichier de configuration
    rm -f /etc/ntp.conf
    cp ntp.conf ${rootdir}/etc/
    chown root:ntp ${rootdir}/etc/ntp.conf
    chmod 644 ${rootdir}/etc/ntp.conf

    # Création d'un lien symbolique pour la rétro-compatibilité
    ln -s ${rootdir}/etc/ntp.conf /etc/ntp.conf

    # Concervation du fichier ntp.drift
    if [ -e /var/lib/ntp/ntp.drift ]; then
        mv /var/lib/ntp/ntp.drift ${rootdir}/var/lib/ntp/ntp.drift
        chown -R ntp:ntp ${rootdir}/var/lib/ntp
    fi
    ln -s ${rootdir}/var/lib/ntp/ntp.drift /var/lib/ntp/ntp.drift

    if [ -e /var/log/ntpstats ]; then
        mv /var/log/ntpstats ${rootdir}/var/log/ntpstats
        chown -R ntp:ntp ${rootdir}/var/log/ntpstats
    fi
    ln -s ${rootdir}/var/log/ntpstats /var/log/ntpstats

    echo -e "NTPD_OPTS='-4 -i ${rootdir} -g'" > /etc/default/ntp

}

set_umask()
{
    if ! grep --quiet "umask" /etc/init.d/ntp; then
        sed -i "\#^PIDFILE=/var/run/ntpd.pid#a umask 027" /etc/init.d/ntp
    fi

}

set_firewall_rules()
{
    echo "-N IN_NTP_CLIENT" >> in-rules.v4
    echo "-A INPUT         -p udp --sport 123 --dport 123 -j IN_NTP_CLIENT" >> in-rules.v4
    echo "-A IN_NTP_CLIENT -p udp --sport 123 --dport 123 -m state --state ESTABLISHED -j ACCEPT" >> in-rules.v4
    echo "-A IN_NTP_CLIENT -j DROP" >> in-rules.v4

    echo "-N OUT_NTP_CLIENT" >> out-rules.v4
    echo "-A OUTPUT         -p udp --sport 123 --dport 123 -j OUT_NTP_CLIENT" >> out-rules.v4
    echo "-A OUT_NTP_CLIENT -p udp --sport 123 --dport 123 -m state --state NEW,ESTABLISHED -j ACCEPT" >> out-rules.v4
    echo "-A OUT_NTP_CLIENT -j DROP" >> out-rules.v4
}

set_ntp_conf
set_umask
set_firewall_rules
