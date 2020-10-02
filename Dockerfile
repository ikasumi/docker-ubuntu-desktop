FROM ubuntu:20.04

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=ja_JP.UTF-8 \
    LC_ALL=${LANG} \
    LANGUAGE=${LANG} \
    TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Install packages
RUN apt-get update && \
    # Install the required packages for desktop    
    apt-get install -y \
      supervisor \
      xvfb \
      ubuntu-mate-desktop \
      x11vnc \
      && \
    # Install utilities(optional).
    apt-get install -y \
      wget \
      curl \
      net-tools \
      vim-tiny \
      xfce4-terminal \
      && \
    # Install japanese language packs(optional)
    apt-get install -y \
      language-pack-ja-base language-pack-ja \
      ibus-anthy \
      fonts-takao \
      && \
    # Clean up
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Ubuntu Desktop
RUN apt-get update && \
    apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && \
    apt-get install -y tightvncserver && \
    mkdir /root/.vnc

ENV USER root
ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd
RUN chmod 600 /root/.vnc/passwd

# https://qiita.com/seigot/items/eef9da58c74eb080617b

CMD /usr/bin/vncserver :1 -geometry 1600x900 -depth 24 && tail -f /root/.vnc/*:1.log

# EXPOSE 8080
EXPOSE 5901
