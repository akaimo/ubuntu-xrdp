FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -x \
 && : "install xrdp" \
 && apt-get update \
 && apt-get install -y \
       xubuntu-desktop \
       xrdp \
       vim \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \

 && : "create xrdp user" \
 && addgroup --gid 999 ubuntu \
 && useradd -m -u 999 -s /bin/bash -g ubuntu ubuntu \
 && echo "ubuntu:ubuntu" | chpasswd \
 && echo "ubuntu    ALL=(ALL) ALL" >> /etc/sudoers \

 && : "setup xrdp" \
 && echo "xfce4-session" > /home/ubuntu/.xsession \
 && echo 'export XDG_SESSION_DESKTOP=xubuntu\n\
export XDG_DATA_DIRS=/usr/share/xfce4:/usr/share/xubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop:/usr/share\n\
export XDG_CONFIG_DIRS=/etc/xdg/xdg-xubuntu:/etc/xdg:/etc/xdg'\
>> /home/ubuntu/.xsessionrc \
 && chown ubuntu:ubuntu /home/ubuntu/.xsession \
 && chown ubuntu:ubuntu /home/ubuntu/.xsessionrc

CMD service xrdp start && tail -f /var/log/xrdp.log
