FROM resin/rpi-raspbian:jessie
MAINTAINER k-tahiro

RUN sudo apt-get update && sudo apt-get -y upgrade
RUN sudo apt-get install -y \
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
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN cd /usr/local/src && \
    sudo wget https://sourceforge.net/projects/netatalk/files/netatalk/3.1.10/netatalk-3.1.10.tar.bz2 && \
    sudo tar xvf netatalk-3.1.10.tar.bz2 && \
    cd netatalk-3.1.10 && \ 
    sudo ./configure \
        --with-init-style=debian-systemd \
        --without-libevent \
        --without-tdb \
        --with-cracklib \
        --enable-krbV-uam \
        --with-pam-confdir=/etc/pam.d \
        --with-dbus-daemon=/usr/bin/dbus-daemon \
        --with-dbus-sysconf-dir=/etc/dbus-1/system.d \
        --with-tracker-pkgconfig-version=1.0 && \ 
    sudo make && \
    sudo make install

CMD ["/usr/sbin/init"]
