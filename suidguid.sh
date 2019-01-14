#!/bin/bash

remove_suidguid_mount()
{
  # À désactiver, sauf si absolument nécessaire pour les utilisateurs.
  if [ -e /bin/mount ]; then
      chmod u-s /bin/mount
      chmod g-s /bin/mount
  fi

  # À désactiver, sauf si absolument nécessaire pour les utilisateurs.
  if [ -e /bin/umount ]; then
      chmod u-s /bin/umount
      chmod g-s /bin/umount
  fi
}

remove_suidguid_nfs()
{
  # À désactiver si NFSv4 est inutilisé.
  if [ -e /sbin/mount.nfs4 ]; then
      chmod u-s /sbin/mount.nfs4
      chmod g-s /sbin/mount.nfs4
  fi

  # À désactiver si NFSv2/3 est inutilisé.
  if [ -e /sbin/mount.nfs ]; then
      chmod u-s /sbin/mount.nfs
      chmod g-s /sbin/mount.nfs
  fi

  # À désactiver si NFSv4 est inutilisé.
  if [ -e /sbin/umount.nfs4 ]; then
      chmod u-s /sbin/umount.nfs4
      chmod g-s /sbin/umount.nfs4
  fi

  # À désactiver si NFSv2/3 est inutilisé.
  if [ -e /sbin/umount.nfs ]; then
      chmod u-s /sbin/umount.nfs
      chmod g-s /sbin/umount.nfss
  fi
}

remove_suidguid_fuse()
{
  # À désactiver sauf si des utilisateurs doivent monter des partitions FUSE.
  if [ -e /usr/bin/fusermount ]; then
      chmod u-s /usr/bin/fusermount
      chmod g-s /usr/bin/fusermount
  fi
}

remove_suidguid_network()
{
  # (IPv6) Idem ping.
  if [ -e /bin/ping6 ]; then
      chmod u-s /bin/ping6
      chmod g-s /bin/ping6
  fi

  # (IPv4) Retirer droit setuid, sauf si un programme le requiert pour du monitoring.
  if [ -e /bin/ping ]; then
      chmod u-s /bin/ping
      chmod g-s /bin/ping
  fi

  # (IPv4) Idem ping.
  if [ -e /usr/sbin/traceroute ]; then
      chmod u-s /usr/sbin/traceroute
      chmod g-s /usr/sbin/traceroute
  fi

  # (IPv6) Idem ping.
  if [ -e /usr/sbin/traceroute6 ]; then
      chmod u-s /usr/sbin/traceroute6
      chmod g-s /usr/sbin/traceroute6
  fi

  # À désactiver.
  if [ -e /bin/netreport ]; then
      chmod u-s /bin/netreport
      chmod g-s /bin/netreport
  fi
}

remove_suidguid_user()
{
  # Permet de vérifier le mot de passe utilisateur pour des programmes non root. À désactiver si inutilisé.
  if [ -e /sbin/unix_chkpwd ]; then
      chmod u-s /sbin/unix_chkpwd
      chmod g-s /sbin/unix_chkpwd
  fi

  # À désactiver.
  if [ -e /usr/bin/chfn ]; then
      chmod u-s /usr/bin/chfn
      chmod g-s /usr/bin/chfn
  fi

  # À désactiver.
  if [ -e /usr/bin/chsh ]; then
      chmod u-s /usr/bin/chsh
      chmod g-s /usr/bin/chsh
  fi

  # À désactiver si pas d’authentification de groupe.
  if [ -e /usr/bin/gpasswd ]; then
      chmod u-s /usr/bin/gpasswd
      chmod g-s /usr/bin/gpasswd
  fi

  # À désactiver.
  if [ -e /usr/bin/chage ]; then
      chmod u-s /usr/bin/chage
      chmod g-s /usr/bin/chage
  fi

  # À désactiver si pas d’authentification de groupe.
  if [ -e /usr/bin/newgrp ]; then
      chmod u-s /usr/bin/newgrp
      chmod g-s /usr/bin/newgrp
  fi

  # À désactiver si le suexec Apache n’est pas utilisé.
  if [ -e /usr/sbin/suexec ]; then
      chmod u-s /usr/sbin/suexec
      chmod g-s /usr/sbin/suexec
  fi

  # À désactiver si PolicyKit n’est pas utilisé.
  if [ -e /usr/bin/pkexec ]; then
      chmod u-s /usr/bin/pkexec
      chmod g-s /usr/bin/pkexec
  fi

  # À désactiver (permet de changer le propriétaire des PTY avant l’existence de devfs).
  if [ -e /usr/lib/pt_chown ]; then
      chmod u-s /usr/lib/pt_chown
      chmod g-s /usr/lib/pt_chown
  fi

  # À désactiver, sauf si des utilisateurs non root doivent pouvoir changer leur mot de passe.
  # if [ -e /usr/bin/passwd ]; then
  #     chmod u-s /usr/bin/passwd
  #     chmod g-s /usr/bin/passwd
  # fi

  # TODO
  # /usr/bin/ssh-agent

  # Vérifie la validité du mot de passe de l'utilisateur courant
  if [ -e /usr/bin/expiry ]; then
    chmod u-s /usr/bin/expiry
    chmod g-s /usr/bin/expiry
  fi

  # Vérifie la validité du mot de passe de l'utilisateur courant
  if [ -e /sbin/unix_chkpwd ]; then
    chmod u-s /sbin/unix_chkpwd
    chmod g-s /sbin/unix_chkpwd
  fi
}

remove_suidguid_timer()
{
  # À désactiver si atd n’est pas utilisé.
  if [ -e /usr/bin/at ]; then
      chmod u-s /usr/bin/at
      chmod g-s /usr/bin/at
  fi

  # À désactiver si cron n’est pas requis.
  if [ -e /usr/bin/crontab ]; then
      chmod u-s /usr/bin/crontab
      chmod g-s /usr/bin/crontab
  fi
}

remove_suidguid_mail()
{
  # À désactiver. Utiliser un mailer local comme ssmtp.
  if [ -e /usr/bin/mail ]; then
      chmod u-s /usr/bin/mail
      chmod g-s /usr/bin/mail
  fi

  # À désactiver sauf si procmail est requis.
  if [ -e /usr/bin/procmail ]; then
      chmod u-s /usr/bin/procmail
      chmod g-s /usr/bin/procmail
  fi

  # À désactiver si Exim n’est pas utilisé.
  if [ -e /usr/sbin/exim4 ]; then
      chmod u-s /usr/sbin/exim4
      chmod g-s /usr/sbin/exim4
  fi

  # À désactiver.
  if [ -e /usr/bin/wall ]; then
      chmod u-s /usr/bin/wall
      chmod g-s /usr/bin/wall
  fi
}

remove_suidguid_r()
{
  # Obsolète. À désactiver.
  if [ -e /usr/bin/rlogin ]; then
      chmod u-s /usr/bin/rlogin
      chmod g-s /usr/bin/rlogin
  fi

  # Obsolète. À désactiver.
  if [ -e /usr/bin/rsh ]; then
      chmod u-s /usr/bin/rsh
      chmod g-s /usr/bin/rsh
  fi

  # Obsolète. À désactiver.
  if [ -e /usr/bin/rcp ]; then
      chmod u-s /usr/bin/rcp
      chmod g-s /usr/bin/rcp
  fi
}

remove_suidguid_X()
{
  # À désactiver sauf si le serveur X est requis.
  # if [ -e /usr/bin/X ]; then
  #     chmod u-s /usr/bin/X
  #     chmod g-s /usr/bin/X
  # fi

  # À désactiver.
  if [ -e /usr/bin/screen ]; then
      chmod u-s /usr/bin/screen
      chmod g-s /usr/bin/screen
  fi
}

remove_suidguid()
{
    # À désactiver. Remplacer par mlocate et slocate.
    if [ -e /usr/bin/locate ]; then
        chmod u-s /usr/bin/locate
        chmod g-s /usr/bin/locate
    fi

    # À désactiver quand D-BUS n’est pas utilisé.
    # if [ -e /usr/lib/dbus-1.0/dbus-daemon-launch-helper]; then
    #     chmod u-s /usr/lib/dbus-1.0/dbus-daemon-launch-helper
    #     chmod g-s /usr/lib/dbus-1.0/dbus-daemon-launch-helper
    # fi

    # À désactiver.
    if [ -e /usr/lib/openssh/ssh-keysign ]; then
        chmod u-s /usr/lib/openssh/ssh-keysign
        chmod g-s /usr/lib/openssh/ssh-keysign
    fi

    # À désactiver si le profil utempter SELinux n’est pas utilisé.
    if [ -e /usr/libexec/utempter/utempter ]; then
        chmod u-s /usr/libexec/utempter/utempter
        chmod g-s /usr/libexec/utempter/utempter
    fi

    # CVE-2017-6964 : Execution locale de code
    if [ -e /usr/lib/eject/dmcrypt-get-device ]; then
      chmod u-s /usr/lib/eject/dmcrypt-get-device
      chmod g-s /usr/lib/eject/dmcrypt-get-device
    fi

    # Permet de copier une ligne du terminal courant vers un autre terminal.
    if [ -e /usr/bin/bsd-write ]; then
      chmod u-s /usr/bin/bsd-write
      chmod g-s /usr/bin/bsd-write
    fi
}

remove_suidguid_mount
remove_suidguid_nfs
remove_suidguid_fuse
remove_suidguid_network
remove_suidguid_user
remove_suidguid_timer
remove_suidguid_mail
remove_suidguid_r
remove_suidguid_X
remove_suidguid
