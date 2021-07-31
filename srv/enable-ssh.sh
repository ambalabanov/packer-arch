#!/usr/bin/env bash

# Vagrant-specific configuration
/usr/bin/useradd --comment 'Vagrant User' --create-home --user-group vagrant
echo "vagrant:vagrant" | chpasswd
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_vagrant
/usr/bin/chmod 0440 /etc/sudoers.d/10_vagrant
/usr/bin/systemctl start sshd.service
sed -i '/^\[DHCPv4\]/a ClientIdentifier=mac' /etc/systemd/network/20-ethernet.network
# sed -i 's/DHCP=yes/DHCP=ipv4/' /etc/systemd/network/20-ethernet.network
/usr/bin/systemctl restart systemd-networkd.service