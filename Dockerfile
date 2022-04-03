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
  #  && mkdir -p /var/lib/zookeeper \
    && rm zookeeper-3.4.6.tar.gz

ADD zoo.cfg /usr/local/zookeeper/conf/

WORKDIR /usr/local/zookeeper/bin/

CMD ["zkServer.sh", "restart"]