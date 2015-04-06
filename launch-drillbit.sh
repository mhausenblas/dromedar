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

sudo /opt/drill/apache-drill-0.8.0/bin/drillbit.sh start

exit 0