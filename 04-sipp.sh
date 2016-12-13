#!/bin/bash

source $HOME/00-colors.sh

cd /root
git clone https://github.com/SIPp/sipp.git
cd sipp
./build.sh --full
