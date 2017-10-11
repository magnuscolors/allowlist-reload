#!/bin/bash

while true
do
        # wait until file is modified
        inotifywait -e modify  /code/KeyPortal/iplog-www


                echo "copy Nginx allow-list"
                cp /code/KeyPortal/iplog-www /etc/nginx/conf.d/keyportal-allow.conf
                echo "Reloading Nginx Configuration"
                curl --unix-socket /var/run/docker.sock -X POST http:/v1.24/containers/nginx/kill?signal=HUP

done