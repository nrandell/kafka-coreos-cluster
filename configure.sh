#! /bin/bash

if [ $# -ne 2 ]
then
  echo "usage: configure <jvm memory> <number of servers>"
  exit -1
fi

rm -f kafka*.service

JVM_MEM=$1
SERVER_COUNT=$2

INDEX=0
while [ $INDEX -lt $SERVER_COUNT ]
do
	ID=$(($INDEX+1))
	BROKER_HOST="linode-london-infrastructure-$ID"
	sed -e "s/#JVM_MEM#/$JVM_MEM/" -e "s/#BROKER_HOST#/$BROKER_HOST/" kafka.service.template > kafka@$ID.service
	let INDEX=INDEX+1
done



