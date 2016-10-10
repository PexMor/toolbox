#!/bin/bash -x

source d00-lib.sh

BN=$(basename "$0")
NAM=${BN##nx0-if}
NAM=${NAM%%squid.sh}
echo "use config $NAM"
NO=$NAM

source d00-cfg-r$NO.sh

echo DD=$DD

DPID=$(docker inspect --format '{{ .State.Pid }}' "$DNAME")
DIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$DNAME")

echo DPID=$DPID DIP=$DIP

DI=$[$NO % 10]
SPORT=${DI}3128
DPORT=3128

#sudo iptables -t nat -A POSTROUTING -s $DIP -d $DIP -p tcp -m tcp --dport $DPORT -j MASQUERADE
#sudo iptables -t nat -A DOCKER ! -i docker0 -p tcp -m tcp --dport $SPORT -j DNAT --to-destination $DIP:$DPORT
#sudo iptables -t filter -A DOCKER -d $DIP ! -i docker0 -o docker0 -p tcp -m tcp --dport $DPORT -j ACCEPT

sudo iptables -t nat -A POSTROUTING -d $DIP -p tcp -m tcp --dport $DPORT -j MASQUERADE

sudo iptables -t nat -N MOO
sudo iptables -t nat -A MOO -p tcp -m tcp --dport $SPORT -j DNAT --to-destination $DIP:$DPORT

sudo iptables -t nat -A PREROUTING -j MOO
sudo iptables -t nat -A OUTPUT -j MOO
