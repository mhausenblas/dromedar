#!/bin/bash

###############################################################################
# Apache Drill Drillbit launch script.
#
# Usage:
#
#  ./launch-drillbit.sh
#
# Author: Michael Hausenblas
# Init: 2015-04-06


set -e # exit on error immediately

/opt/drill/bin/drillbit.sh start

exit 0