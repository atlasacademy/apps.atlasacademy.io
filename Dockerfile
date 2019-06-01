FROM webdevops/nginx
MAINTAINER sadisticsolutione@gmail.com

COPY no-cache.conf /opt/docker/etc/nginx/vhost.common.d/10-no-cache.conf

RUN mkdir -p /app /src \
 && cd /src \
 && curl -L -o drop-serializer-react-master.tar.gz https://github.com/atlasacademy/drop-serializer-react/archive/master.tar.gz \
 && tar -zxvf drop-serializer-react-master.tar.gz \
 && cp -r /src/drop-serializer-react-master/build /app/drop-serializer \
 && curl -L -o drop-serializer-react-beta.tar.gz https://github.com/atlasacademy/drop-serializer-react/archive/beta.zip \
 && tar -zxvf drop-serializer-react-beta.tar.gz \
 && cp -r /src/drop-serializer-react-beta/build /app/drop-serializer-beta \
 && chown -R 1000:1000 /app
