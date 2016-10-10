#!/bin/bash

source d00-lib.sh

BN=$(basename "$0")
NAM=${BN##d03-run}
NAM=${NAM%%.sh}
if [ "x$NAM" = "xXXX" ]; then
    echo "please create symlink that configures this script (like: d03-run200.sh)"
    exit -1
fi
echo "use config $NAM"
NO=$NAM

source d00-cfg-r$NO.sh

echo DD=$DD

# -p 12003:2003 \
# -it --rm
# --net=none \

xmkdir "$DRH/tst"
xmkdir "$DD"
xmkdir "$DD/www-data"
touch "$DD/bash_history"

# docker image name
CFG="$DRH/whichImage"
echo "CFG=$CFG"

if [ -f "$CFG" ]; then
    source "$CFG"
    if [ "x$DIN" = "x" ]; then
        exit -1
    fi
else
    DIN=router
fi

echo "DIN(Docker Image Name)=$DIN"

docker run \
    -d \
    --privileged \
    -h router$NO \
    --name router$NO \
    -v "$DD:/host" \
    -v "$DRH/tst:/tst" \
    -v "$DD/www-data:/var/www-data" \
    -v "$DD/bash_history:/root/.bash_history" \
    $DIN
