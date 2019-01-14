#!/bin/sh

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
    sudo_path=$(which sudo)
    chown root:sudoexec ${sudo_path}
    chmod 6750 ${sudo_path}
}

set_sudoers
remove_sudoers_d
set_sudo_group
