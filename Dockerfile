FROM resin/rpi-raspbian:jessie
MAINTAINER k-tahiro

RUN sudo apt-get update && sudo apt-get install -y \
        build-essential \
        libevent-dev \
        libssl-dev \
        libgcrypt11-dev \
        libkrb5-dev \
        libpam0g-dev \
        libwrap0-dev \
        libdb-dev \
        libtdb-dev \
        libmysqlclient-dev \
        avahi-daemon \
        libavahi-client-dev \
        libacl1-dev \
        libldap2-dev \
        libcrack2-dev \
        systemtap-sdt-dev \
        libdbus-1-dev \
        libdbus-glib-1-dev \
        libglib2.0-dev \
        libio-socket-inet6-perl \
        tracker \
        libtracker-sparql-1.0-dev \
        libtracker-miner-1.0-dev
ADD https://sourceforge.net/projects/netatalk/files/netatalk/3.1.10/netatalk-3.1.10.tar.bz2 /usr/local/src/

WORKDIR /usr/local/src
RUN sudo tar xvf netatalk-3.1.10.tar.bz2
WORKDIR netatalk-3.1.10
RUN sudo ./configure --with-init-style=debian-sysv
RUN sudo make
RUN sudo make install

COPY afp.conf /usr/local/etc/
WORKDIR ~/

RUN useradd netatalk && \
    mkdir /TimeMachine && \
    chown -R netatalk:netatalk /TimeMachine && \
    echo "netatalk:netatalk" | chpasswd

EXPOSE [548, 5353]
CMD ["service", "netatalk", "start"]
