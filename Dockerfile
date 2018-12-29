FROM ubuntu:18.04

RUN set -x \
 && apt-get update \
 && apt-get install -y xrdp vim \
 && : "setup xrdp" \
 && sed -e 's/^new_cursors=true/new_cursors=false/g' -i /etc/xrdp/xrdp.ini \
 && echo 'export GNOME_SHELL_SESSION_MODE=ubuntu\n\
export XDG_CURRENT_DESKTOP=ubuntu:GNOME\n\
export XDG_DATA_DIRS=/usr/share/ubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop\n\
export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg'\n\
>> ~/.xsessionrc \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD service xrdp start && tail -f /var/log/xrdp.log
