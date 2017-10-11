#!/bin/bash

while true
do
        # wait until file is modified
        inotifywait -e modify  /code/KeyPortal/iplog-www

             curl --unix-socket /var/run/docker.sock -X GET http:/v1.24/containers/json?all=false \
                | ./jq '[ .[].Names | .[] | . == "/nginx" ] \
                | reduce .[] as $item (false; . | $item)'
             if [ $? -eq "true" ]
             then
                echo "copy Nginx allow-list"
                cp /code/KeyPortal/iplog-www /etc/nginx/conf.d/keyportal-allow.conf
                echo "Reloading Nginx Configuration"
                curl --unix-socket /var/run/docker.sock -X POST http:/v1.24/containers/nginx/kill?signal=HUP
             fi
done