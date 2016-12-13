#!/bin/bash

source $HOME/00-colors.sh

cd /root
wget http://www.pjsip.org/release/2.5.5/pjproject-2.5.5.tar.bz2
tar xjf pjproject-2.5.5.tar.bz2
cd pjproject-2.5.5
./configure && make dep && make clean && make
