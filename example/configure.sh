#!/bin/sh

_step_counter=0
step() {
	_step_counter=$(( _step_counter + 1 ))
	printf '\n\033[1;36m%d) %s\033[0m\n' $_step_counter "$@" >&2  # bold cyan
}

step 'Adjust network interface'
sed -i -e 's/ens2/ens3/' /etc/netplan/01-netcfg.yaml
netplan apply

step 'Adjust sshd_conf'
chmod +w /etc/sudoers
sed -i -e 's/%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
chmod -w /etc/sudoers
echo root:root | chpasswd
#sed -i -e 's/.PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i -e 's/.PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

step 'Install nix'
curl -L https://nixos.org/nix/install > /tmp/install
chmod +x /tmp/install
mkdir -p /nix
chown builder /nix
chmod 755 /nix
sudo -i -u builder /tmp/install
