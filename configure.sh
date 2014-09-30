#! /bin/bash

if [ $# -ne 1 ]
then
  echo "usage: configure <number of servers>"
  exit -1
fi

rm kafka*.service

SERVER_COUNT=$1

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
	sed -e "s/#ZOOKEEPERS#/$ALLIPS/" kafka.service.template > kafka@$ID.service
	let INDEX=INDEX+1
done



