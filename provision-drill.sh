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

DRILL_TARGET=/opt/drill/apache-drill-0.8.0/bin/drillbit.sh

## Install Apache Drill if not yet done
if [[ ! -f $DRILL_TARGET ]]; then 
    echo "Drill seems not to be set up, yet. Going to install it now ..."
    wget http://getdrill.org/drill/download/apache-drill-0.8.0.tar.gz
    sudo mkdir -p /opt/drill
    sudo tar -xvzf apache-drill-0.8.0.tar.gz -C /opt/drill
    rm apache-drill-0.8.0.tar.gz
fi

echo "Drill is installed and ready to rock."

exit 0