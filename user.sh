#!/bin/sh

#Documents de référence
# "Recommandations de securite relatives a un systeme GNU/Linux"
# https://www.ssi.gouv.fr/reco-securite-systeme-linux/

ADMIN_USER=osadmin

set_default_users()
{
    usermod -a -G sudoexec $ADMIN_USER
}

# Valeur de umask
#
# "Recommandations de securite relatives a un systeme GNU/Linux" R35
set_default_umask()
{
    sed -i 's/^UMASK.*$/UMASK\t077/' /etc/login.defs
}

set_default_users
set_default_umask
