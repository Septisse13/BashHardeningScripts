#!/bin/sh

cmdline_linux=""

# "Recommandations de securite relatives a un systeme GNU/Linux"
# https://www.ssi.gouv.fr/reco-securite-systeme-linux/

# "Recommandations de securite relatives a un systeme GNU/Linux" R22
iommu()
{
    cmdline_linux=${cmdline_linux}"iommu=force "
}

# "Recommandations de securite relatives a un systeme GNU/Linux"
# https://www.ssi.gouv.fr/reco-securite-systeme-linux/

# "Recommandations de securite relatives a un systeme GNU/Linux" R25
yama()
{
    cp sysctl.d/40-yama-sysctl.conf /etc/sysctl.d/
    chown root:root /etc/sysctl.d/40-yama-sysctl.conf
    chmod 644 /etc/sysctl.d/40-yama-sysctl.conf
}

iommu
yama
sed -i "s/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX=\"${cmdline_linux}\"/" /etc/default/grub
update-grub
