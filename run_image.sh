#!/bin/sh
docker run --privileged -d --name netatalk k-tahiro/netatalk /sbin/init
docker exec -it netatalk /bin/bash
