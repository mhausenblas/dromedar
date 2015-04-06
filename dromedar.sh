#!/bin/bash

###############################################################################
# Drill on Mesos (Dromeda) provision and init script.
#
# Usage:
#
#  ./dromedar.sh
#
# Author: Michael Hausenblas
# Init: 2015-04-06


set -e # exit on error immediately


###############################################################################
# Global variables

SCRIPT_PATH=`dirname $0`

echo Provisioning Apache Drill 0.8

wget http://getdrill.org/drill/download/apache-drill-0.8.0.tar.gz
sudo mkdir -p /opt/drill
sudo tar -xvzf apache-drill-0.8.0.tar.gz -C /opt/drill

#sudo apt-get -y install mesos
#sudo apt-get -y install marathon

# Install marathon-python
wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py
pip install marathon
rm -f get-pip.py

exit 0