#!/bin/bash

source d00-lib.sh

BN=$(basename "$0")
NAM=${BN##t01-ntpdate}
NAM=${NAM%%.sh}
if [ "x$NAM" = "xXXX" ]; then
    echo "please create symlink that configures this script (like: t01-ntpdate200.sh)"
    exit -1
fi
echo "use config $NAM"
NO=$NAM

source d00-cfg-r$NO.sh

echo DD=$DD

echo "ntpdate -dqu $*"

sudo docker exec -it --privileged $DNAME ntpdate -dqu $*
