FROM debian:bullseye-slim
ENV VERSION 2.9.19

WORKDIR /
VOLUME /hosthome
VOLUME /shared
RUN mkdir -p /root/pcaps/
COPY net_test /root/net_test/
COPY etc /root/etc/
COPY preproc_rules /root/preproc_rules/
COPY rules /root/rules/
COPY so_rules /root/so_rules/
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

ENV PYTHONIOENCODING=utf-8
ENV LANG C.UTF-8

CMD /bin/bash

WORKDIR ..
