#!/bin/sh
docker run --rm --name netatalk -d -it k-tahiro/netatalk -p 548:548 -p 5353:5353 -v /mnt/harddisk/TimeMachine:/TimeMachine
