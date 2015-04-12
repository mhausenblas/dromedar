#!/usr/bin/env python
"""
Launches as many Drillbits as specified in relation to dataset size under query.
Assumes that Drill is installed and Mesos + Marathon are deployed and running.

Usage: 
     
    ./qsf.py $MARATHON_URL $[FACTOR=100]

Example: 
     
    ./qsf.py http://localhost:8080 10 # launch QFS == 1:10, that is 1 Drillbit per 10MB


@author: Michael Hausenblas, http://mhausenblas.info/#i
@since: 2015-04-06
@status: init
"""

import logging
import os
import sys
import time

from marathon import MarathonClient
from marathon.models import MarathonApp

################################################################################
# Defaults
#

DEBUG = True

if DEBUG:
  FORMAT = '%(asctime)-0s %(levelname)s %(message)s [at line %(lineno)d]'
  logging.basicConfig(level=logging.DEBUG, format=FORMAT, datefmt='%Y-%m-%dT%I:%M:%S')
else:
  FORMAT = '%(asctime)-0s %(message)s'
  logging.basicConfig(level=logging.INFO, format=FORMAT, datefmt='%Y-%m-%dT%I:%M:%S')

QSF_DEFAULT = 100  # 1 Drillbit per 100MB dataset size

def launch_drillbits(marathon_url, scale_factor):
    logging.info('Launching Drillbits using %s and scale factor %d' %(marathon_url, int(scale_factor)))

    # launch via Marathon REST API
    c = MarathonClient(marathon_url)
    c.create_app('dromedar-drill', MarathonApp(cmd='dromedar-master/launch-drillbit.sh', uris=['https://github.com/mhausenblas/dromedar/archive/master.zip'], mem=400, cpus=1))
    
    print('Drillbits are deployed: DATASETSIZE, NUM_DRILLBITS')
    
################################################################################
# Main script
#
if __name__ == '__main__':
    try:
        marathon_url = sys.argv[1] # Marathon URL to use
        try:
            scale_factor = sys.argv[2]
        except:
            scale_factor = QSF_DEFAULT
        # TODO: rewrite into HTTP-based long-running service, also: Marathon URL comes from dromedar main launch
        launch_drillbits(marathon_url, scale_factor)
    except Exception, e:
        print(e)
        print(__doc__)
        sys.exit(2)