FROM nrandell/openjre-centos
MAINTAINER Nick Randell <nick@nickrandell.com>

RUN wget -q -O - http://apache.mirrors.pair.com/kafka/0.8.1.1/kafka_2.9.2-0.8.1.1.tgz | tar -xzf - -C /opt
ADD server.properties.template /opt/kafka_2.9.2-0.8.1.1/config/
ADD start.sh /opt/kafka_2.9.2-0.8.1.1/

EXPOSE 9092
WORKDIR /opt/kafka_2.9.2-0.8.1.1
ENV KAFKA_HOME /opt/kafka_2.9.2-0.8.1.1


VOLUME ["/data","/opt/kafka_2.9.2-0.8.1.1/logs"]
ENTRYPOINT ["/opt/kafka_2.9.2-0.8.1.1/start.sh"]



