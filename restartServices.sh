#! /bin/bash

for service in *.service
do
    echo "Restarting $service"
    fleetctl stop $service
    sleep 10
    fleetctl destroy $service
    sleep 10
    fleetctl start $service
    sleep 10
    fleetctl status $service
done
