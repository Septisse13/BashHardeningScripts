#!/bin/bash

# Dependancies :
#    - iptables-persistant
#    - bind9

set_umask()
{
    if ! grep UMask /lib/systemd/system/bind9.service; then
        sed -i "/^\[Service\]/a UMask=0027" /lib/systemd/system/bind9.service
    fi
}

set_chroot()
{
  # Création de la prison
  rootdir=/var/chroot/bind
  mkdir -p ${rootdir}/{dev,etc/bind,var/run/named,var/cache/bind}
  chgrp bind ${rootdir}/{var/run/named,var/cache/bind}
  chmod g+w ${rootdir}/{var/run/named,var/cache/bind}
  chgrp bind ${rootdir}
  chmod 750 ${rootdir}
  rm -f /etc/bind/named.conf

  # Conf par défaut
  cp -r /etc/bind ${rootdir}/etc/
  chgrp bind ${rootdir}/etc/bind/rndc.key

  # Création du fichier de configuration
  cp bind/named.conf ${rootdir}/etc/bind
  chown root:bind ${rootdir}/etc/bind/named.conf
  chmod 644 ${rootdir}/etc/bind/named.conf

  # Création d'un lien symbolique pour la rétro-compatibilité
  ln -s ${rootdir}/etc/bind/named.conf /etc/bind/named.conf

  # Lien vers le fichier localtime
  ln -s /etc/localtime ${rootdir}/etc/localtime

  # Peripheriques
  mknod ${rootdir}/dev/null c 1 3
  mknod ${rootdir}/dev/random c 1 8
  chmod 666 ${rootdir}/dev/{null,random}

  # Journalisation
  echo -e "\$AddUnixListenSocket ${rootdir}/dev/log" >> /etc/rsyslog.d/bind-chroot.conf

  # Arguments par défaut
  sed -i  "s|OPTIONS=.*|OPTIONS=\"-u bind -t ${rootdir}\"|" /etc/default/bind9
  #sed -i  '\|^\[Service\]|a EnvironmentFile=-/etc/default/bind9' /lib/systemd/system/bind9.service
  sed -i  "s|^ExecStart=.*|ExecStart=/usr/sbin/named -f -u bind -t ${rootdir}|" /lib/systemd/system/bind9.service

  # Resistance a la maj
  # dpkg-divert --divert /lib/systemd/system/bind9.service.orig --rename /lib/systemd/system/bind9.service

}

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

set_umask
set_chroot
set_firewall_rules
