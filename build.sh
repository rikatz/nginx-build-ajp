#!/bin/bash

mkdir /build

AJP_VERSION="fcbb2ccca4901d317ecd7a9dabb3fec9378ff40f"
NGINX_VERSION="1.21.6"

curl -sSL http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz -o /build/nginx.tar.gz
curl -sSL https://github.com/msva/nginx_ajp_module/archive/${AJP_VERSION}.tar.gz -o /build/ajp.tar.gz

cd /build
tar -xvzf nginx.tar.gz
tar -xvzf ajp.tar.gz

cd /build/nginx-${NGINX_VERSION}
./configure --add-dynamic-module=/build/nginx_ajp_module-${AJP_VERSION}
make modules
cp ./objs/ngx_http_ajp_module.so /build/ngx_http_ajp_module.so


