#!/bin/bash

source d00-lib.sh

BN=$(basename "$0")
NAM=${BN##t02-gen}
NAM=${NAM%%.sh}
if [ "x$NAM" = "xXXX" ]; then
    echo "please create symlink that configures this script (like: t01-ntpdate200.sh)"
    exit -1
fi
echo "use config $NAM"
NO=$NAM

source d00-cfg-r$NO.sh

echo DD=$DD

CFG="$DRH/cfg/t02-gen"
echo "CFG=$CFG"

if [ "x$1" = "x" ]; then
    if [ -f "$CFG" ]; then
        source "$CFG"
        if [ "x$CMD" = "x" ]; then
            exit -2
        fi
    else
        exit -1
    fi
else
    NTPSRV=$1
fi

echo "ntpdate -dqu $NTPSRV"

sudo docker exec -it --privileged $DNAME /bin/bash -x -c "$CMD"
