FROM webdevops/nginx
MAINTAINER sadisticsolutione@gmail.com

COPY no-cache.conf /opt/docker/etc/nginx/vhost.common.d/10-no-cache.conf

RUN mkdir -p /app /src \
 && cd /src \

 && curl -L -o drop-serializer-react-master.tar.gz https://github.com/atlasacademy/drop-serializer-react/archive/master.tar.gz \
 && tar -zxvf drop-serializer-react-master.tar.gz \
 && cp -r /src/drop-serializer-react-master/build /app/drop-serializer \

 && curl -L -o fgo-lookup.tar.gz https://github.com/jycl1234/fgo-lookup/archive/master.tar.gz \
 && tar -zxvf fgo-lookup.tar.gz \
 && cp -r /src/fgo-lookup-master/dist /app/drop-lookup \

 && curl -L -o aa-db.tar.gz https://github.com/atlasacademy/aa-db/archive/master.tar.gz \
 && tar -zxvf aa-db.tar.gz \
 && cp -r /src/aa-db-master/build /app/db \

 && chown -R 1000:1000 /app \
 && rm -rf /src
