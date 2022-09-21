#!/bin/bash

BASEDIR=$(dirname $0)
. $BASEDIR/setup.sh

/bin/echo "BROKER $HOST:$PORT_BROKER actuator/customtime is ";
curl -u bactor:bactorpass $CURL_OPTS http://$HOST:$PORT_BROKER/actuator/customtime | jq

