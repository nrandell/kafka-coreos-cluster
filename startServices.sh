#! /bin/bash

for service in *.service
do
	echo "Starting $service"
    fleetctl start $service
done
