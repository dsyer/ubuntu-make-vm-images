Scripts to create a VM image using `virt-builder`.

Pre-requisites: `virt-builder` (via `libguestfs-tools`) and Qemu.

```
$ run.sh
```

Wait for it to finish and start the VM. In another terminal you can SSH in as the user "builder":

```
$ ssh builder@192.168.2.19 -p 2222
builder@kvm$ lsb_release  -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 18.04 LTS
Release:	18.04
Codename:	bionic
```

> NOTE: you need a non-loopback address of localhost.

You can login with a hostname if you configure that stuff in `~/.ssh/config`:

```
Host qemu
	 HostName 192.168.2.19
	 Port 2222
	 User builder
```

then just `ssh qemu`. This is useful when using the remote extension in VS Code.