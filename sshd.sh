#/bin/sh

#Documents de référence
# "Recommandations de securite relatives a un systeme GNU/Linux"
# https://www.ssi.gouv.fr/reco-securite-systeme-linux/

remove_user_keys()
{
    for home in $(ls -1 /home); do
        rm -f ${home}/.ssh/*
    done
}

remove_server_keys()
{
    for key in $(find /etc/ssh/ -name "ssh_host*" -type f -printf "%f\n"); do
        rm -f /etc/ssh/${key}
    done
}

set_sshd_config()
{
    cp sshd_config /etc/ssh/
    chown root:root /etc/ssh/sshd_config
    chmod 644 /etc/ssh/sshd_config
}

# Valeur de umask
#
# "Recommandations de securite relatives a un systeme GNU/Linux" R35
set_sshd_systemd()
{
    if ! grep UMask /etc/systemd/system/sshd.service; then
        sed -i "/^\[Service\]/a UMask=0027" /etc/systemd/system/sshd.service
    fi
}

set_firewall_rules()
{
    echo "-N IN_SSH_SERVER" >> in-rules.v4
    echo "-A INPUT         -p tcp --dport 22 -m multiport --sports 1024:65535 -j IN_SSH_SERVER" >> in-rules.v4
    echo "-A IN_SSH_SERVER -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT" >> in-rules.v4
    echo "-A IN_SSH_SERVER -j DROP" >> in-rules.v4

    echo "-N OUT_SSH_SERVER" >> out-rules.v4
    echo "-A OUTPUT         -p tcp --sport 22  -m multiport --dports 1024:65535 -j OUT_SSH_SERVER" >> out-rules.v4
    echo "-A OUT_SSH_SERVER -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT" >> out-rules.v4
    echo "-A OUT_SSH_SERVER -j DROP" >> out-rules.v4
}

#remove_user_keys
#remove_server_keys
set_sshd_config
set_sshd_systemd
set_firewall_rules
