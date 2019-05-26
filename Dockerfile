FROM webdevops/nginx
MAINTAINER sadisticsolutione@gmail.com

COPY no-cache.conf /opt/docker/etc/nginx/vhost.common.d/10-no-cache.conf

RUN mkdir -p /app /src \
 && cd /src \
 && curl -L -o drop-serializer-react.tar.gz https://github.com/atlasacademy/drop-serializer-react/archive/master.tar.gz \
 && tar -zxvf drop-serializer-react.tar.gz \
 && cp -r /src/drop-serializer-react-master/build /app/drop-serializer \
 && chown -R 1000:1000 /app
