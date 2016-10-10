#!/bin/bash

sudo docker run \
    -it \
    --rm \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --cap-add SYS_ADMIN --security-opt seccomp=unconfined \
    -h router200 \
    --name router200 \
    xlinux/toolbox
