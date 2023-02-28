#!/bin/bash

if ! [ -f disk.qcow ]; then
    echo No disk prepared. Creating...
    sudo virt-builder --ssh-inject "builder:file:$HOME/.ssh/id_rsa.pub" --root-password password:root --edit '/etc/default/keyboard: s/^XKBLAYOUT=.*/XKBLAYOUT="gb"/' --format qcow2 --install "$(cat example/packages | tr '\n' ,)" --run ./example/configure.sh -o disk.qcow ubuntu-18.04
    if ! [ "$?" == "0" ]; then
        echo Failed
        exit 1
    fi
	sudo chown $USER:$USER disk.qcow
else
    echo Using existing disk.qcow disk
fi

echo Ready to go. Exposing ssh on port 2222 of host.
echo Use 'CTRL-A C' to switch to monitor.
if qemu-img snapshot -l disk.qcow | grep init; then
    snapshot="-loadvm init"
fi
qemu-system-x86_64 -hda disk.qcow -enable-kvm -net nic -net user,hostfwd=tcp::2222-:22 -nographic --rtc base=localtime -m 512 $snapshot

# KVM notes:
# $ sudo usermod -aG kvm $(whoami)
# Log out and log in to join the new group
