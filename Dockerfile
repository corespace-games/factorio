FROM zombymediaic/zubuntu:latest
LABEL org.opencontainers.image.authors="AsP3X"

RUN apt-get update && apt upgrade -y \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    sudo

RUN apt-get install -y htop nano vim git wget

EXPOSE 34197/tcp
EXPOSE 34197/udp


# Install dependencies for the application
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt install -y curl wget file tar bzip2 gzip unzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat lib32gcc-s1 lib32stdc++6 xz-utils

# Create a user for the application
RUN useradd -m fctrserver && echo "fctrserver:fctrserver" | chpasswd && adduser fctrserver sudo
USER fctrserver

WORKDIR /home/fctrserver/factorio
RUN wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh fctrserver
RUN ./fctrserver install