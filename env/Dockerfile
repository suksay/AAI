FROM ubuntu:latest

RUN useradd -ms /bin/bash silas
USER silas

WORKDIR /home/silas

RUN apt install -y wget && apt install -y unzip
RUN wget http://github.com/JanusGraph/janusgraph/releases/download/v0.2.0/janusgraph-0.2.0-hadoop2.zip

RUN unzip janusgraph-0.2.0-hadoop2.zip
RUN cd janusgraph-0.2.0-hadoop2/

EXPOSE 8182 9200

ENTRYPOINT ["/bin/bash", "/janusgraph-0.2.0-hadoop2/bin/janusgraph.sh"]
