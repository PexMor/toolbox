#!/bin/bash

DNAME=router200

sudo docker exec -it $DNAME /bin/bash -x -c "dig www.google.com"

alias d200="docker exec -it router200"
