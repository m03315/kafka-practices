FROM openjdk:8-jdk-slim-bullseye

EXPOSE 2181/tcp

RUN apt-get -y update \
    && apt-get -y install --no-install-recommends curl \
    # automatically, you don't need to do it yourself):
    && apt-get clean \
    # Delete index files we don't need anymore:
    && rm -rf /var/lib/apt/lists/* \
    && curl https://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz -o zookeeper-3.4.6.tar.gz \
    && tar -zxf zookeeper-3.4.6.tar.gz \
    && mv zookeeper-3.4.6 /usr/local/zookeeper \
    && mkdir -p /var/lib/zookeeper\
    && echo '\
    tickTime=2000 \n\
    dataDir=/var/lib/zookeeper \n\
    clientPort=2181 \n\
    4lw.commands.whitelist=* \n\
    server.1=localhost:2888:3888;2181 \n\
    ' >> /usr/local/zookeeper/conf/zoo.cfg
    
CMD /usr/local/zookeeper/bin/zkServer.sh start



