#!/bin/sh

CONTENT=$(curl -s http://ip-api.com/json/)
longitude=$(echo $CONTENT | jq .lon)
latitude=$(echo $CONTENT | jq .lat)

wlsunset -T 5500

wlsunset -l $latitude -L $longitude

