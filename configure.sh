#! /bin/bash

if [ $# -ne 2 ]
then
  echo "usage: configure <jvm memory> <number of servers>"
  exit -1
fi

rm kafka*.service

JVM_MEM=$1
SERVER_COUNT=$2

while read ip
do
	IPS+=("$ip:2181")
done < <(fleetctl list-units  -no-legend | grep 'zookeeper...service' | grep  active | cut -f 2 | cut -d / -f 2)

ALLIPS=$(IFS=","; echo "${IPS[*]}")
echo $ALLIPS

INDEX=0
while [ $INDEX -lt $SERVER_COUNT ]
do
	ID=$(($INDEX+1))
	IP=${IPS[$INDEX]}
	sed -e "s/#ZOOKEEPERS#/$ALLIPS/" -e "s/#JVM_MEM#/$JVM_MEM/" kafka.service.template > kafka@$ID.service
	let INDEX=INDEX+1
done



