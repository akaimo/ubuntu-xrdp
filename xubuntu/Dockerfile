FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -x \
 && : "install xrdp" \
 && apt-get update \
 && apt-get install -y \
       xubuntu-desktop \
       xrdp \
       dbus \
       vim \
       supervisor \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN set -x \
 && : "create xrdp user" \
 && addgroup --gid 999 ubuntu \
 && useradd -m -u 999 -s /bin/bash -g ubuntu ubuntu \
 && echo "ubuntu:ubuntu" | chpasswd \
 && echo "ubuntu    ALL=(ALL) ALL" >> /etc/sudoers

RUN set -x \
 && : "setup xrdp" \
 && echo "xfce4-session" > /home/ubuntu/.xsession \
 && echo 'export XDG_SESSION_DESKTOP=xubuntu\n\
export XDG_DATA_DIRS=/usr/share/xfce4:/usr/share/xubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop:/usr/share\n\
export XDG_CONFIG_DIRS=/etc/xdg/xdg-xubuntu:/etc/xdg:/etc/xdg'\
>> /home/ubuntu/.xsessionrc \
 && chown ubuntu:ubuntu /home/ubuntu/.xsession \
 && chown ubuntu:ubuntu /home/ubuntu/.xsessionrc

RUN set -x \
 && : "setup dbus" \
 && mkdir /var/run/dbus \
 && chown messagebus /var/run/dbus

RUN set -x \
 && : "setup supervisord" \
 && echo "[supervisord]\nnodaemon=true\n" > /etc/supervisor/conf.d/supervisord.conf \
 && echo "[program:xrdp]\ncommand=/usr/sbin/xrdp --nodaemon\n" >> /etc/supervisor/conf.d/supervisord.conf \
 && echo "[program:xrdp-sesman]\ncommand=/usr/sbin/xrdp-sesman -n\n" >> /etc/supervisor/conf.d/supervisord.conf \
 && echo "[program:dbus-daemon]\ncommand=/usr/bin/dbus-daemon --system --nofork\nuser=messagebus\n" >> /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]

