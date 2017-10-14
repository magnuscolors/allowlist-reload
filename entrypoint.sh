#!/bin/bash

while true
do
        # wait until file is modified
        inotifywait -e modify  $ALLOW_LIST


                echo "copy Nginx allow-list"
                cp $ALLOW_LIST /etc/nginx/conf.d/keyportal-allow.conf
                echo "Reloading Nginx Configuration"
                curl --unix-socket /var/run/docker.sock -X POST http:/v1.24/containers/nginx/kill?signal=HUP

done