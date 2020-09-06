# stage 1 : prepare the sources
FROM node:13.8.0-alpine3.11 as build
WORKDIR /src
RUN apk add --no-cache curl
ENV GENERATE_SOURCEMAP false

RUN curl -L -o fgo-lookup.tar.gz https://github.com/jycl1234/fgo-lookup/archive/master.tar.gz
RUN tar -zxvf fgo-lookup.tar.gz
RUN mkdir -p /app/ && cp -r fgo-lookup-master/dist /app/drop-lookup

RUN curl -L -o drop-serializer.tar.gz https://github.com/atlasacademy/drop-serializer-react/archive/master.tar.gz
RUN tar -zxvf drop-serializer.tar.gz
RUN cd drop-serializer-react-master && npm install && npm run build
RUN mkdir -p /app/ && cp -r drop-serializer-react-master/build/ /app/drop-serializer

RUN curl -L -o aa-db.tar.gz https://github.com/atlasacademy/aa-db/archive/master.tar.gz
RUN tar -zxvf aa-db.tar.gz
RUN cd aa-db-master && npm install && npm run build
RUN mkdir -p /app/ && cp -r aa-db-master/build/ /app/db

# stage 2 : copy & fire things up
FROM webdevops/nginx

COPY no-cache.conf /opt/docker/etc/nginx/vhost.common.d/10-no-cache.conf
COPY index.html /app/index.html
COPY --from=build /app/ /app/
RUN chown -R 1000:1000 /app
ENV WEB_DOCUMENT_INDEX=index.html
