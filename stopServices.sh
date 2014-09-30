#! /bin/bash

for service in *.service
do
	echo "Stopping $service"
    fleetctl stop $service
    fleetctl destroy $service
done
