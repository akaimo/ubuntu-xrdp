FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -x \
 && apt-get update \
 && : "install desktop environment" \
 && apt-get install -y \
       kubuntu-desktop \
       network-manager \
       network-manager-gnome \
       xrdp \
       supervisor

RUN set -x \
 && apt-get install -y \
       vim \
       curl \
       wget \
       git

RUN set -x \
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
 && sed -e 's/^new_cursors=true/new_cursors=false/g' -i /etc/xrdp/xrdp.ini \
 && echo "startkde" > /home/ubuntu/.xsession \
 && echo 'export XDG_CURRENT_DESKTOP=KDE\n\
export XDG_DATA_DIRS=/usr/share/plasma:/usr/local/share:/usr/share:/var/lib/snapd/desktop\n\
export XDG_CONFIG_DIRS=/etc/xdg/xdg-plasma:/etc/xdg:/usr/share/kubuntu-default-settings/kf5-settings'\
>> /home/ubuntu/.xsessionrc \
 && chown ubuntu:ubuntu /home/ubuntu/.xsession \
 && chown ubuntu:ubuntu /home/ubuntu/.xsessionrc

RUN set -x \
 && : "setup dbus" \
 && mkdir -p /var/run/dbus \
 && chown messagebus:messagebus /var/run/dbus \
 && dbus-uuidgen --ensure

RUN set -x \
 && : "setup supervisord" \
 && echo "[supervisord]\nnodaemon=true\n" > /etc/supervisor/conf.d/supervisord.conf \
 && echo "[program:xrdp]\ncommand=/usr/sbin/xrdp --nodaemon\n" >> /etc/supervisor/conf.d/supervisord.conf \
 && echo "[program:xrdp-sesman]\ncommand=/usr/sbin/xrdp-sesman -n\n" >> /etc/supervisor/conf.d/supervisord.conf \
 && echo "[program:dbus-daemon]\ncommand=/usr/bin/dbus-daemon --system --nofork\nuser=messagebus\n" >> /etc/supervisor/conf.d/supervisord.conf \
 && echo "[program:network-manager]\ncommand=/usr/sbin/NetworkManager -n" >> /etc/supervisor/conf.d/supervisord.conf

COPY org.freedesktop.NetworkManager.pkla /etc/polkit-1/localauthority/50-local.d/org.freedesktop.NetworkManager.pkla

RUN set -x \
 && : "setup network-manager" \
 && usermod -aG netdev ubuntu \
 && touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf

CMD ["/usr/bin/supervisord"]

