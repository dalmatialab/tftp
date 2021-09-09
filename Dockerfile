FROM ubuntu:20.04

LABEL maintainer="dalmatialab"

RUN apt-get update && apt-get install -y tftpd-hpa wget genisoimage syslinux pxelinux tzdata

EXPOSE 69/udp

ENV PXEBOOT="false" DEBIAN_FRONTEND="noninteractive" TZ="Europe/Zagreb"

RUN mkdir -p /tmp/tftpboot/pxelinux.cfg

COPY ./configuration/pxescript.sh /.

COPY ./configuration/default /tmp/tftpboot/pxelinux.cfg

ENTRYPOINT ["/bin/bash","/pxescript.sh"]

CMD ["-v -L --secure /srv/tftp"]
