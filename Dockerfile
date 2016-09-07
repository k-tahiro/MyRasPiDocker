FROM resin/rpi-raspbian:jessie

RUN set -x && \
    sudo apt-get update && \
    sudo apt-get -y upgrade && \
    sudo apt-get -y install screen vim git make wget && \
    sudo apt-get -y install libssl-dev libgcrypt11-dev libpam0g-dev libwrap0-dev libdb-dev libavahi-client-dev libacl1-dev libldap2-dev && \
    cd /usr/local/src && \
    sudo wget http://prdownloads.sourceforge.net/netatalk/netatalk-3.0.3.tar.bz2 && \
    sudo bzip2 -dc netatalk-3.0.3.tar.bz2 | sudo tar xvf - && \
    cd netatalk-3.0.3/ && \
    screen && \
    sudo ./configure --with-init-style=debian && \ 
    sudo make && \
    sudo make install

CMD ["bash"]
