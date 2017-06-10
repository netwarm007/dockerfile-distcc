FROM tim03/gcc:6.3
MAINTAINER Chen, Wenli <chenwenli@chenwenli.com>

ENV ALLOW 192.168.0.0/16

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
 && apt-get -qqy install python3 python3-dev libiberty-dev unzip \
 rpm fakeroot alien sudo \
 && apt-get autoremove -y\
 && apt-get clean autoclean\
 && rm -rf /var/lib/apt/lists/*
WORKDIR /root/src
RUN wget http://github.com/distcc/distcc/archive/master.zip \
 && unzip master.zip && rm master.zip \
 && cd distcc-master && ./autogen.sh && ./configure  --sysconfdir=/etc \
 && make deb && make install-deb \
 && cd .. && rm -rf distcc-master

ENTRYPOINT /usr/bin/distccd --daemon  --allow=${ALLOW} --verbose --no-detach "$@"
