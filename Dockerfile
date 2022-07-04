FROM        python:3.9.13-alpine3.16
LABEL       author="Sonicscream" maintainer="sonicscream@dgd.cx"
RUN         apk update
RUN         apk upgrade
RUN         apk add --no-cache --virtual delete_me git cargo g++
RUN         apk add --no-cache --virtual keep_me zlib-dev jpeg-dev libffi-dev openssl-dev libjpeg libstdc++ openssl
RUN         export TMPDIR='/var/tmp'
RUN         pip install git+git://github.com/dgdcx/piqueserver.git@b10c38193d7ed26c20e4af30a14d99cedf899061
RUN         apk del delete_me
RUN         pip install websockets
RUN         pip install geoip2
RUN         adduser -D -h /home/container container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container
COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
