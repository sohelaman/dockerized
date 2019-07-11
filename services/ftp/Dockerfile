FROM debian:buster-slim
LABEL maintainer="Sohel Aman"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y vsftpd

ARG FTP_USER=john
ARG FTP_PASS=doe
RUN useradd -mg users -G ftp -s /bin/false -p "$(openssl passwd -1 ${FTP_PASS})" ${FTP_USER}

RUN echo ${FTP_USER} > /etc/vsftpd.userlist

RUN mv /etc/vsftpd.conf /etc/vsftpd.conf.bak
COPY config/vsftpd.conf /etc/vsftpd.conf

ENTRYPOINT service vsftpd start && /bin/bash
