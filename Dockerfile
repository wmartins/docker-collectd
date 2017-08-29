FROM alpine:3.6

MAINTAINER William Martins <wwwhmartins@gmail.com>

ARG COLLECTD_VERSION=5.7.2
ARG DOCKER_CONTRIB_REVISION=2c2a8af7bcc3529dabe2a1cb71386f41259fba69
ARG PREFIX=/opt/collectd

RUN apk add --no-cache \
    autoconf \
    automake \
    bison \
    flex \
    g++ \
    gcc \
    git \
    libtool \
    linux-headers \
    make \
    pkgconfig \
    libltdl

RUN git clone https://github.com/collectd/collectd.git && \
    cd collectd && \
    git checkout collectd-${COLLECTD_VERSION} && \
    ./build.sh && \
    ./configure --prefix=${PREFIX} && \
    make && \
    make install && \
    git checkout ${DOCKER_CONTRIB_REVISION} && \
    CC="cpp -I/usr/include/linux/can" make -C contrib/docker/rootfs_prefix && \
    cp contrib/docker/rootfs_prefix/rootfs_prefix.so ${PREFIX}/lib

ENV LD_PRELOAD ${PREFIX}/lib/rootfs_prefix.so
ENV PATH ${PATH}:${PREFIX}/sbin

RUN rm -rf collectd

RUN apk del --no-cache \
    autoconf \
    automake \
    bison \
    curl \
    flex \
    g++ \
    gcc \
    git \
    libtool \
    linux-headers \
    make \
    pkgconfig

WORKDIR /opt/collectd

CMD ["collectd", "-f"]
