FROM alpine:latest
RUN  mkdir -p /opt/janushome/admin

RUN groupadd admin -g 1001
RUN adduser -u 1000 -h /opt/janushome/admin -S -D -G aaiadmin -s /bin/bash admin

WORKDIR /opt/janushome/admin

RUN apk add wget
RUN apk add unzip
RUN wget http://github.com/JanusGraph/janusgraph/releases/download/v0.2.0/janusgraph-0.2.0-hadoop2.zip

RUN unzip janusgraph-0.2.0-hadoop2.zip

