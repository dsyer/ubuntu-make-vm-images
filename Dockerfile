FROM cloudfoundry/run:base

RUN apt-get update
RUN apt-get install -y qemu

COPY disk.qcow /

ENTRYPOINT [ "qemu-system-x86_64", "-enable-kvm", "-hda", "disk.qcow", "-net", "nic", "-net", "user,hostfwd=tcp::8080-:8080", "-localtime", "-m", "512", "-loadvm", "petclinic", "-nographic" ]