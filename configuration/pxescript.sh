#/bin/bash

if [ $PXEBOOT = "true" ]; then
        mv /usr/lib/PXELINUX/lpxelinux.0 /tmp/tftpboot
        cp -v /usr/lib/syslinux/modules/bios/{menu.c32,ldlinux.c32,libcom32.c32,libutil.c32} /tmp/tftpboot
        cp -r /tmp/tftpboot/* /srv/tftp/
	/usr/sbin/in.tftpd $1
else
	/usr/sbin/in.tftpd $1
fi
