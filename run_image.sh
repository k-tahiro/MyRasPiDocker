#!/bin/sh
docker run --name netatalk -d -it k-tahiro/netatalk -p 548:548 -v /mnt/harddisk/TimeMachine:/TimeMachine
