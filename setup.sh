#!/bin/bash

###############################################################################
# The Dromedar setup script. Is used on an edge node (your laptop, etc.) to
# install the local and remote parts of Dromedar (using Marathon).
#
# Usage:
#
#  ./setup.sh
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
./dromedar.py

echo Done. Now you can start using Dromedar via qsf.py ...

exit 0