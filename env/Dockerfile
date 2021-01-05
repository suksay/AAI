FROM ubuntu:latest

RUN groupadd silas -g 1000
RUN adduser -u 1000 -h /opt/home/silas -S -D -G silas -s /bin/bash silas

USER silas

RUN apt install -y wget && apt install -y unzip
RUN wget http://github.com/JanusGraph/janusgraph/releases/download/v0.2.0/janusgraph-0.2.0-hadoop2.zip

RUN unzip janusgraph-0.2.0-hadoop2.zip
RUN cd janusgraph-0.2.0-hadoop2/

EXPOSE 8182
EXPOSE 9200

ENTRYPOINT ["/bin/bash", "/janusgraph-0.2.0-hadoop2/bin/janusgraph.sh"]
