#!/bin/sh

CONTENT=$(curl -s http://ip-api.com/json/)
longitude=$(echo $CONTENT | jq .lon)
latitude=$(echo $CONTENT | jq .lat)

wlsunset -l $latitude -L $longitude -t 4000 -T 5500

