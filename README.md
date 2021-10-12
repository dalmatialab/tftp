![example workflow](https://github.com/dalmatialab/tftp/actions/workflows/main.yml/badge.svg)
# Supported tags and respective Dockerfile links
 - [5.2-rc-3](https://github.com/dalmatialab/tftp/blob/d750bda4e6ffdb744a64e6ed32954eb1d2d48e2e/Dockerfile)
 - [5.2-rc-2](https://github.com/dalmatialab/tftp/blob/9f31d326336cbc7b9b641bb4eefe50511b4f9d69/Dockerfile)
 - [5.2-rc-1](https://github.com/dalmatialab/tftp/blob/3db71a7ac242476e04fc86093196ff9c30759b7e/Dockerfile)

# What is TFTP server ?

TFTP Server is used for simple file transfer (typically for boot-loading remote devices). Trivial File Transfer Protocol (TFTP) is a simple protocol for exchanging files between two TCP/IP machines. TFTP servers allow connections from a TFTP Client for sending and receiving files. The TFTP protocol supports only file send and receive operations. File delete, move, and rename are not supported. Due to its limitations, TFTP is a complement to the regular FTP and not a replacement. It is only used when its simplicity is important, and its lack of features is acceptable. The most common application is bootstrapping, although it can be used for other purposes as well.

# What is PXE boot ?

Preboot Execution Environment(PXE) is a client-server interface that allows computers in a network to be booted from the server before deploying the obtained PC image in local and remote offices, for PXE enabled clients. PXE network boot is performed using client-server protocols like DHCP(Dynamic Host Configuration Protocol) and TFTP(Trivial File Transfer Protocol). PXE will be enabled by default on all computers.

# How to use this image

## Start standard TFTP server

	$ docker run -d --name some-tftp -p 69:69/udp image:tag 
 
## Start TFTP server with PXE boot configuration

	$ docker run -d --name tftp-pxeboot -p 69:69/udp -e PXEBOOT=true image:tag
Where:
 - *tag* is docker image version

## Environment variables

**PXEBOOT**

This variable defines the role of the TFTP server, if the value is true, server is used for PXE boot, otherwise server is used as standard TFTP server. Default value: false

**TZ**

This variable defines the timezone for the server. Default value: Europe/Zagreb

## Ports

TFTP is a UDP-based protocol, and it uses port 69 for TFTP transfers.

## Volumes

To use Your files for TFTP server, mount container path `/srv/tftp/` to host path.

	$ -v some-host-path:/srv/tftp

To use Your PXE boot configuration, mount container path `/var/lib/tftpboot/` to host path. If the value of ENV variable PXEBOOT is true, configuration will be copied to the TFTP directory.

	$ -v some-host-path:/var/lib/tftpboot/

## NOTE 

Details about TFTP parameters may be found [here](https://manpages.debian.org/testing/tftpd-hpa/tftpd.8.en.html).

This image uses HTTP protocol for PXE boot, so boot filename is `lpexlinux.0` instead of standard `pxelinux.0` file. The difference between these two files, is that `lpxelinux.0` enables downloading and loading initial setup files (initrd.gz, linux) from HTTP server directly, instead of downloading and loading them from the local source. Boot file `lpexlinux.0` also provides loading files from local source.
Default image configuration provides installation of Ubuntu (Focal, Bionic, Xenial) and Debian (Bullseye, Buster, Stretch) distribution. Preseed files for mentioned distributions are fetched from the GitHub repository.
