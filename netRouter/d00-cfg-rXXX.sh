#!/bin/bash

if [ "x$BN" = "x" ]; then
    BN=$(basename "$0")
fi

if [ "x$NO" = "x" ]; then
    NAM=${BN##d00-cfg-r}
    NAM=${NAM%%.sh}
    echo "use config $NAM"
    NO=$NAM
fi

DD=$HOME/.dockerRouter/$NO
DNAME=router$NO

HPFX=outer
BRNAME=outerbr
