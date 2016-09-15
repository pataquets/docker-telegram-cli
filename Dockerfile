FROM pataquets/ubuntu:trusty

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      luajit \
      luarocks \
      libreadline-dev \
      libconfig-dev \
      libssl-dev \
      lua5.2 \
      liblua5.2-dev \
      libevent-dev \
      libjansson-dev \
      libpython-dev \
      make \
      git \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/

RUN \
  git clone --recursive https://github.com/vysheng/tg.git /tg && \
  cd /tg && \
  ./configure && \
  cd /tg && \
  make && \
  mv -v /tg/bin/* /usr/bin/ && \
  mkdir -vp /etc/telegram-cli/ && \
  mv -v /tg/tg-server.pub /etc/telegram-cli/server.pub && \
  rm -rf /tg/

ENTRYPOINT /usr/bin/telegram-cli
