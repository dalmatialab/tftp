FROM ubuntu:20.04

LABEL maintainer="dalmatialab"

RUN apt-get update && apt-get install -y tftpd-hpa wget genisoimage syslinux pxelinux

EXPOSE 69/udp

RUN mkdir -p /var/lib/tftpboot/pxelinux.cfg

RUN mv /usr/lib/PXELINUX/lpxelinux.0 /var/lib/tftpboot

RUN ["/bin/bash", "-c", "cp -v /usr/lib/syslinux/modules/bios/{menu.c32,ldlinux.c32,libcom32.c32,libutil.c32} /var/lib/tftpboot"]

COPY ./configuration/default /var/lib/tftpboot/pxelinux.cfg

COPY ./preseed /var/lib/tftpboot/preseed/

CMD /usr/sbin/in.tftpd -v -L --secure /var/lib/tftpboot
