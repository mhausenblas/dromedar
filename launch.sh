#!/bin/bash

###############################################################################
# The Dromedar launch script. It is used on an edge node such as your laptop
# to install the local dependencies and launch Dromedar (using Marathon).
#
# Usage:
#
#  ./launch.sh
#
# Author: Michael Hausenblas
# Init: 2015-04-12


set -e # exit on error immediately


###############################################################################
# Global variables

SCRIPT_PATH=`dirname $0`

echo Ensure prerequisits are met ...

# Install marathon-python on edge node, if not yet present
if ! $(python -c 'import marathon' &> /dev/null); then
    wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
    sudo python get-pip.py
    sudo pip install marathon
    rm -f get-pip.py
fi

# Launch Dromedar from edge node
./dromedar.py http://localhost:8080

echo Done launching Dromedar. Now you can start using Apache Drill via qsf.py ...

exit 0