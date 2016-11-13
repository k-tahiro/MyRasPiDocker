FROM resin/rpi-raspbian:jessie
MAINTAINER k-tahiro

RUN sudo apt-get update && sudo apt-get -y upgrade
RUN sudo apt-get install -y automake libtool build-essential pkg-config checkinstall git-core avahi-daemon libavahi-client-dev libssl-dev libdb-dev db-util db5.1-util libgcrypt11-dev libcrack2-dev libpam0g-dev libdbus-1-dev libdbus-glib-1-dev libglib2.0-dev libwrap0-dev systemtap-sdt-dev libacl1-dev libldap2-dev
RUN cd /usr/local/src && \
    sudo wget https://sourceforge.net/projects/netatalk/files/netatalk/3.1.10/netatalk-3.1.10.tar.bz2 && \
    sudo tar xvf netatalk-3.1.10.tar.bz2
RUN cd /usr/local/src/netatalk-3.1.10 && sudo ./configure --with-init-style=debian --with-zeroconf --with-cracklib --with-pam-confdir=/etc/pam.d --with-dbus-sysconf-dir=/etc/dbus-1/system.d 
RUN sudo checkinstall --fstrans=no

CMD ["bash"]
