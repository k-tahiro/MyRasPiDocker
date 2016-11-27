FROM resin/rpi-raspbian:jessie
MAINTAINER k-tahiro

RUN sudo apt-get update && \
    sudo apt-get install -y \
        wget \
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

WORKDIR /usr/local/src
RUN sudo wget https://sourceforge.net/projects/netatalk/files/netatalk/3.1.10/netatalk-3.1.10.tar.bz2 && \
    sudo tar xvf netatalk-3.1.10.tar.bz2 && \
    cd netatalk-3.1.10 && \
    sudo ./configure --with-init-style=debian-sysv && \
    sudo make && \
    sudo make install

WORKDIR /root
COPY afp.conf /usr/local/etc/

RUN useradd netatalk && \
    echo "netatalk:netatalk" | chpasswd && \
    mkdir /TimeMachine && \
    chown -R netatalk:netatalk /TimeMachine

EXPOSE 548
CMD ["service", "netatalk", "start"]
