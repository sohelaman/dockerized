FROM debian:buster-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y vsftpd

## Add ftp user
ARG FTP_USER=john
ARG FTP_PASS=doe
RUN useradd -mg users -G ftp -s /sbin/nologin -p "$(openssl passwd -1 ${FTP_PASS})" ${FTP_USER}

## Setup ftp root
RUN mkdir /home/${FTP_USER}/ftp
RUN chown nobody:nogroup /home/${FTP_USER}/ftp
RUN chmod a-w /home/${FTP_USER}/ftp

## Setup writable folder
RUN mkdir /home/${FTP_USER}/ftp/files
RUN chown ${FTP_USER}:ftp /home/${FTP_USER}/ftp/files
RUN chmod a+w /home/${FTP_USER}/ftp/files
RUN chmod 755 -R /home/${FTP_USER}/ftp/files

## Add to userlist
RUN echo ${FTP_USER} > /etc/vsftpd.userlist

## config
RUN mv /etc/vsftpd.conf /etc/vsftpd.conf.bak
COPY config/vsftpd.conf /etc/vsftpd.conf

ENTRYPOINT date && hostname -i && service vsftpd start && /bin/bash
