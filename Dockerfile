FROM alpine:3.18.4 as builder

RUN apk update \
    && apk upgrade \
    && apk add -U --no-cache \
    bash \
    openssl \
    zlib \
    curl \
    ca-certificates \
    patch \
    && apk add bash \
    gcc \
    clang \
    libc-dev \
    make \
    automake \    
    openssl-dev \
    pcre-dev \
    zlib-dev \
    linux-headers \
    libxslt-dev \
    gd-dev \
    geoip-dev \
    perl-dev \
    libedit-dev \
    mercurial \
    alpine-sdk \
    findutils \
    curl \
    ca-certificates \
    patch \
    libaio-dev \
    openssl \
    cmake \
    util-linux \
    lmdb-tools \
    wget \
    curl-dev \
    libprotobuf \
    git g++ pkgconf flex bison doxygen yajl-dev lmdb-dev libtool autoconf libxml2 libxml2-dev \
    python3 \
    libmaxminddb-dev \
    bc \
    unzip \
    dos2unix \
    yaml-cpp \
    coreutils

COPY build.sh /build.sh
RUN /build.sh

FROM cgr.dev/chainguard/static:latest
COPY --from=builder /build/ngx_http_ajp_module.so /ngx_http_ajp_module.so

