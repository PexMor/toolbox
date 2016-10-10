#!/bin/bash

source d00-lib.sh

BN=$(basename "$0")
NAM=${BN##d05-killAndRm}
NAM=${NAM%%.sh}
if [ "x$NAM" = "xXXX" ]; then
    echo "please create symlink that configures this script (like: d04-bash200.sh)"
    exit -1
fi
echo "use config $NAM"
NO=$NAM

source d00-cfg-r$NO.sh

echo DD=$DD

sudo docker kill $DNAME
sudo docker rm $DNAME
