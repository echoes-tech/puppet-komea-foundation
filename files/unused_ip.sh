#!/bin/bash

homeDir="/home/ksfuser"
curl -ks --cacert $homeDir/ca.pem --cert $homeDir/cert.pem --key $homeDir/key.pem 'https://foreman.ksf.local:8443/dhcp/192.168.122.0/unused_ip' -X GET

