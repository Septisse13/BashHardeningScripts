#!/bin/sh

#Documents de référence
# "Recommandations de securite relatives a un systeme GNU/Linux"
# https://www.ssi.gouv.fr/reco-securite-systeme-linux/

ADMIN_USER=osadmin
SUDO_GROUP=sudoexec

# Pense bete :
# groupe sudo : utilisateur NOPASSWD (désactivé)
# groupe sudoexec : utilisateur autorisés à utiliser sudo

set_sudoers()
{
    cp sudoers /etc/sudoers
    chown root:root /etc/sudoers
    chmod 600 /etc/sudoers
}

remove_sudoers_d()
{
    rm -f /etc/sudoers.d/*
}

set_sudoers_d()
{
    cp -r sudoers.d/* /etc/sudoers.d/
    chown root:root /etc/sudoers.d/*
    chmod 600 /etc/sudoers.d/*
}

set_sudo_group()
{
    groupadd ${SUDO_GROUP}
    sudo_path=$(which sudo)
    chown root:${SUDO_GROUP} ${sudo_path}
    chmod 6750 ${sudo_path}
}

set_default_users()
{
    usermod -a -G ${SUDO_GROUP} $ADMIN_USER
}

# Valeur de umask
#
# "Recommandations de securite relatives a un systeme GNU/Linux" R35
set_default_umask()
{
    sed -i 's/^UMASK.*$/UMASK\t077/' /etc/login.defs
}

set_sudoers
remove_sudoers_d
set_sudo_group
set_default_users
set_default_umask
