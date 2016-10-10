#!/bin/bash -x

source d00-lib.sh

BN=$(basename "$0")
NAM=${BN##nx0-if}
NAM=${NAM%%dhcp.sh}
echo "use config $NAM"
NO=$NAM

source d00-cfg-r$NO.sh

echo DD=$DD

DPID=$(docker inspect --format '{{ .State.Pid }}' "$DNAME")
DIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$DNAME")

echo DPID=$DPID DIP=$DIP

VLAN=$NO
HPFX="if$VLAN"
BRNAME="brif$VLAN"
BE=eth1

sudo docker exec -it $DNAME /bin/bash -x -c 'rm -f /etc/resolv.conf.dhclient*'
sudo docker exec -it $DNAME ip ro del default
sudo docker exec -it $DNAME dhclient -v $HPFX-int
sudo docker exec -it $DNAME /bin/bash -x -c 'ls -l /etc/resolv.conf.dhclient*'
sudo docker exec -it $DNAME /bin/bash -x -c 'cat /etc/resolv.conf.dhclient* >/etc/resolv.conf'
sudo docker exec -it $DNAME cat /etc/resolv.conf

