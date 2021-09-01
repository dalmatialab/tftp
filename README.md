# Supported tags and respective Dockerfile links


# What is TFTP server ?

TFTP Server is used for simple file transfer (typically for boot-loading remote devices). Trivial File Transfer Protocol (TFTP) is a simple protocol for exchanging files between two TCP/IP machines. TFTP servers allow connections from a TFTP Client for sending and receiving files. The TFTP protocol supports only file send and receive operations. File delete, move, and rename are not supported. Due to its limitations, TFTP is acomplement to the regular FTP and not a replacement. It is only used when its simplicity is important, and its lack of features is acceptable. The most common application is bootstrapping, although it can be used for other purposes as well.

# What is PXE boot ?

Preboot Execution Environment(PXE) is a client-server interface that allows computers in a network to be booted from the server before deploying the obtained PC image in local and remote offices, for PXE enabled clients. PXE network boot is performed using client-server protocols like DHCP(Dynamic Host Configuration Protocol) and TFTP(Trivial File Transfer Protocol). PXE will be enabled by default on all computers.

# How to use this image

## Start TFTP server with PXE boot configuration

	docker run -d --name tftp-pxeboot -p 69:69/udp image:tag
Where:
 - *tag* is docker image version

## Ports

TFTP is a UDP-based protocol, and it uses port 69 for TFTP transfers.

## Volumes

To use Your preseed files, mount container path `/var/lib/tftpboot/preseed/` to host path.

	$ -v some-host-path:/var/lib/tftpboot/preseed/

To use Your menu file for PXE boot, mount container path  `/var/lib/tftpboot/pxelinux.cfg/default` to host path.
	$ -v some-host-path:/var/lib/tftpboot/pxelinux.cfg/default

To use any other setup files, menu files or other, mount container path `/var/lib/tftpboot/` to host path.
	$ -v some-host-path:/var/lib/tftpboot/

## NOTE 

This Image uses HTTP protocol for PXE boot, so boot filename is `lpexlinux.0` instead of standard `pxelinux.0` file. Difference betweenthese two files, is that `lpxelinux.0` enables downloading and loading initial setup files(initrd.gz, linux) from HTTP server directly, instead of downloading and loading them from the local source. Boot file `lpexlinux.0` also provides loading files from local source.
Image provides installation of Ubuntu (Focal, Bionic, Xenial) and Debian (Bullseye, Buster, Stretch) distribution. To use your preseed files for these distributions, they should be named as `preseed-codename.cfg` and mounted to the container.
 
