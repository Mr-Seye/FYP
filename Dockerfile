# OS image to pull from
FROM debian:bullseye-slim

# Declare VERSION variable for pulling specific snort version
ENV VERSION 2.9.19


# Declare working directory
WORKDIR /

# Creating perisitent volumes for filesharing with Kathara machines
VOLUME /hosthome
VOLUME /shared

# Create directory for .pcap storage
RUN mkdir -p /root/pcaps/

# Import files from Dockerfile directory to be used in container namely Kathara topology and Snort rule fules
COPY net_test /root/net_test/
COPY etc /root/etc/
COPY preproc_rules /root/preproc_rules/
COPY rules /root/rules/
COPY so_rules /root/so_rules/

# Set source directory to install dependencies, Snort and Kathara
WORKDIR /root/src/

RUN  apt-get update && \
  apt-get -y install \
  build-essential \
  x11-apps \
  vim \
  curl \
  gcc \
  flex \
  bison \
  pkg-config \
  libpcap0.8 \
  libpcap0.8-dev \
  libpcre3 \
  libpcre3-dev \
  libdumbnet1 \
  libdumbnet-dev \
  libdaq2 \
  libdaq-dev \
  zlib1g \
  iptables \
  zlib1g-dev \
  liblzma5 \
  liblzma-dev \
  net-tools \
  luajit \
  libluajit-5.1-dev \
  libssl1.1 \
  libssl-dev \
  xterm \
  tcpreplay && \
  apt-get clean && \
  apt-get update && \
  # Add Kathará public key to keyring
  apt-get -y install gnupg && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 21805A48E6CBBA6B991ABE76646193862B759810 && \
  # Add Kathará repository
  echo "deb https://ppa.launchpadcontent.net/katharaframework/kathara/ubuntu focal main" | tee /etc/apt/sources.list.d/kathara.list && \
  echo "deb-src https://ppa.launchpadcontent.net/katharaframework/kathara/ubuntu focal main" | tee -a /etc/apt/sources.list.d/kathara.list && \
  apt-get update && \
  # Install Kathará
  apt-get -y install kathara && \
  # Install Snort
  curl -L -O https://snort.org/downloads/archive/snort/snort-$VERSION.tar.gz && \
  tar xf ./snort-$VERSION.tar.gz && \
  cd ./snort-$VERSION && \
  ./configure --enable-sourcefire --enable-open-appid && \
  make -j$(nproc) && \
  make install && \
  ldconfig && \
  cd /root && \
  rm -rf /root/src && \
  touch /root/pcaps/local.rules && \
  echo 'export TERM=xterm-256color' >> ~/.bashrc

# rule syntax file
COPY include/hog.vim /root/.vim/syntax/hog.vim
# colorscheme
COPY include/ir_black.vim /root/.vim/colors/ir_black.vim
# vimrc
COPY include/vimrc /root/.vimrc

# Environment variables needed to allow Kathara to run properly
ENV PYTHONIOENCODING=utf-8
ENV LANG C.UTF-8

# Command to set the terminal used
CMD /bin/bash

# Change the directory back to the root directory (this is where the container will launch into)
WORKDIR ..
