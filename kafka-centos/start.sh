#! /bin/bash

if [ "x${BROKER_ID}" = "x" ]
then
	echo "BROKER_ID must be set"
	exit 1
fi

if [ "x${ZOOKEEPERS}" = "x" ]
then
	echo "ZOOKEEPERS must be set"
	exit 1
fi

if [ "x${IP}" = "x" ]
then
	echo "IP must be set"
	exit 1
fi


if [ "x${JVM_MEM}" = "x" ]
then
	echo "JVM_MEM must be set"
	exit 1
fi


sed -e "s/^broker.id=.*$/broker.id=$BROKER_ID/" -e "s/^zookeeper.connect=.*$/zookeeper.connect=$ZOOKEEPERS/" -e "s/^advertised.host.name=.*$/advertised.host.name=$IP/" $KAFKA_HOME/config/server.properties.template > $KAFKA_HOME/config/server.properties

sed -s "s/export KAFKA_HEAP_OPTS=.*$/export KAFKA_HEAP_OPTS=\"-Xmx${JVM_MEM} -Xms${JVM_MEM}\"/" $KAFKA_HOME/bin/kafka-server-start.sh > $KAFKA_HOME/bin/kafka-server-start-modified.sh
chmod +x $KAFKA_HOME/bin/kafka-server-start-modified.sh

exec $KAFKA_HOME/bin/kafka-server-start-modified.sh $KAFKA_HOME/config/server.properties
