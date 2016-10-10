#!/bin/bash -x

source d00-lib.sh

BN=$(basename "$0")
NAM=${BN##nx0-if}
NAM=${NAM%%.sh}
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
BE=eth0

sudo ip link add $HPFX-int type veth peer name $HPFX-ext
sudo ip link set link up dev $HPFX-ext
sudo ip link set netns $DPID dev $HPFX-int
EE=`printf "%04x" $NO`
E1=${EE:0:2}
E2=${EE:2:2}
sudo docker exec -it $DNAME ip link set dev $HPFX-int address 76:9e:ec:00:$E1:$E2
sudo docker exec -it $DNAME ip link set $HPFX-int up

sudo brctl addbr $BRNAME
sudo ip li set $BRNAME up
sudo ip li set $HPFX-ext up

sudo ip link add link ${BE} name ${BE}.$VLAN type vlan id $VLAN
sudo ip li set dev ${BE}.$VLAN up

sudo brctl addif $BRNAME $HPFX-ext
sudo brctl addif $BRNAME ${BE}.$VLAN
