Scripts to create a VM image using `virt-builder`.

Pre-requisites: `virt-builder` (via `libguestfs-tools`), Qemu and a public key in `~/.ssh/id_rsa.pub`.

Build a VM and run it:

```
$ ./run.sh
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

You can login with just a hostname if you configure that stuff in `~/.ssh/config`:

```
Host qemu
	 HostName 192.168.2.19
	 Port 2222
	 User builder
```

then just `ssh qemu`. This is useful when using the remote extension in VS Code.

## Using Nix

The example configuration installed [Nix](https://nixos.org/nix) on top of the base Ubuntu. So you can use that to control dependencies in the runtime environmemt. E.g.

```
$ git

Command 'git' not found, but can be installed with:

sudo apt install git

$ nix-shell -p git
[nix-shell:~]$ git
usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]
...
```

## Docker

You can dockerize the qemu snapshot (see `Dockerfile` included - assumes that you have created a snapshot in the `disk.qcow`). It doesn't start very fast though, and you have to run it `--privileged`.
