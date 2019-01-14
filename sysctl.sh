#/bin/sh

# "Recommandations de securite relatives a un systeme GNU/Linux"
# https://www.ssi.gouv.fr/reco-securite-systeme-linux/

# "Recommandations de securite relatives a un systeme GNU/Linux" R22
network()
{
    cp sysctl.d/10-network-sysctl.conf /etc/sysctl.d/
    chown root:root /etc/sysctl.d/10-network-sysctl.conf
    chmod 644 /etc/sysctl.d/10-network-sysctl.conf
}

# Recommandations de securite relatives a un systeme GNU/Linux" R23
system()
{
    cp sysctl.d/20-system-sysctl.conf /etc/sysctl.d/
    chown root:root /etc/sysctl.d/20-system-sysctl.conf
    chmod 644 /etc/sysctl.d/20-system-sysctl.conf
}

# "Recommandations de securite relatives a un systeme GNU/Linux" R24
kernel_modules()
{
    cp sysctl.d/50-kernelmodule-sysctl.conf /etc/sysctl.d/
    chown root:root /etc/sysctl.d/50-kernelmodule-sysctl.conf
    chmod 644 /etc/sysctl.d/50-kernelmodule-sysctl.conf
}

system
network
kernel_modules

# Rq : On observe trois comportement:
#    - Au demarage, sous Debian Jessie, c'est le service
#      /lib/systemd/systemd-sysctl qui applique les directives contenues dans
#      /etc/sysctl.d/*.
#    - sysctl -p n'applique de les directives de /etc/sysctl.conf.
#    - sysctl --system applique les directives de :
#         -/run/sysctl.d/*.conf
#         -/etc/sysctl.d/*.conf
#         -/usr/local/lib/sysctl.d/*.conf
#         -/usr/lib/sysctl.d/*.conf
#         -/lib/sysctl.d/*.conf
#         -/etc/sysctl.conf
#      Preventivement, afin d'empecher la surcharge involontaire via
#      /etc/sysctl.conf, le lien 99-sysctl.conf est supprime.
rm /etc/sysctl.d/99-sysctl.conf
