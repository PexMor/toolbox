#!/bin/bash

# -v /sys/fs/cgroup:/sys/fs/cgroup:ro \

VOLS="-v /sys/fs/cgroup:/sys/fs/cgroup:ro"
OPTS="--cap-add SYS_ADMIN --security-opt seccomp=unconfined"
# OPTS="--privileged"

# -it --rm
sudo docker run \
    -d \
    $VOLS \
    $OPTS \
    -h router200 \
    --name router200 \
    router

#    systemd.unit=emergency.service
