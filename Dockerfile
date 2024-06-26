FROM debian:11

# define default env variables
ENV GAME cstrike
ENV PORT 27015
ENV MAP de_dust2
ENV MAXPLAYERS 16
ENV SV_LAN 0

# install dependencies
RUN dpkg --add-architecture i386
RUN apt-get update && \
    apt-get install -y libc6-i386 lib32gcc-s1 curl lib32stdc++6 unzip

# create directories
WORKDIR /root
RUN mkdir Steam .steam

# download steamcmd
WORKDIR /root/Steam
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
# ADD steamcmd_linux.tar.gz .

# RUN apt update && apt install -y iputils-ping
# ENTRYPOINT [ "ping", "0.0.0.0" ]

# install CS 1.6 via steamcmd
RUN ./steamcmd.sh +force_install_dir /hlds +login anonymous +app_update 90 validate +quit || true
RUN ./steamcmd.sh +login anonymous +app_update 70 validate +quit || true
RUN ./steamcmd.sh +login anonymous +app_update 10 validate +quit || true
RUN ./steamcmd.sh +force_install_dir /hlds +login anonymous +app_update 90 validate +quit || true
# RUN ./steamcmd.sh +login anonymous +force_install_dir /hlds +app_update 90 validate +quit

# link sdk
WORKDIR /root/.steam
RUN ln -s ../Steam/linux32 sdk32

# start server
WORKDIR /hlds

# copy maps
COPY maps/ ./cstrike/maps/

ENTRYPOINT ./hlds_run -game $GAME -strictportbind -ip 0.0.0.0 -port $PORT +sv_lan $SV_LAN +map $MAP -maxplayers $MAXPLAYERS
