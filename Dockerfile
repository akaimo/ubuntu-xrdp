FROM ubuntu:18.04

# https://qiita.com/yagince/items/deba267f789604643bab
ENV DEBIAN_FRONTEND=noninteractive

RUN set -x \
 && apt-get update \
 && apt-get install -y xubuntu-desktop xrdp tigervnc-standalone-server vim \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && addgroup --gid 999 ubuntu \
 && useradd -m -u 999 -s /bin/bash -g ubuntu ubuntu \
 && echo "ubuntu:ubuntu" | chpasswd \
 && echo "ubuntu    ALL=(ALL) ALL" >> /etc/sudoers \
 && echo "xfce4-session" > ~/.xsession \
 && echo 'export XDG_SESSION_DESKTOP=xubuntu\n\
export XDG_DATA_DIRS=/usr/share/xfce4:/usr/share/xubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop:/usr/share\n\
export XDG_CONFIG_DIRS=/etc/xdg/xdg-xubuntu:/etc/xdg:/etc/xdg'\n\
>> ~/.xsessionrc \
 && cp ~/.xsession /home/ubuntu/.xsession \
 && cp ~/.xsessionrc /home/ubuntu/.xsessionrc \
 && chown ubuntu:ubuntu /home/ubuntu/.xsession \
 && chown ubuntu:ubuntu /home/ubuntu/.xsessionrc

CMD service xrdp start && tail -f /var/log/xrdp.log
