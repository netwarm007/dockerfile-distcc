FROM tim03/ubuntu
MAINTAINER Chen, Wenli <chenwenli@chenwenli.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
 && apt-get -qqy install wget autoconf gcc make python3 python3-dev libiberty-dev unzip \
 gzip bzip2 rpm fakeroot alien sudo \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /root/src
RUN wget http://github.com/distcc/distcc/archive/3.2.zip \
 && unzip 3.2.zip && rm 3.2.zip \
 && cd distcc-3.2 && ./autogen.sh && ./configure  --sysconfdir=/etc \
 && make deb && make install-deb \
 && cd .. && rm -rf distcc-3.2

CMD /usr/bin/distccd --daemon  --allow=10.68.0.0/16 --verbose --no-detach
