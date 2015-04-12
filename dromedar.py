#!/usr/bin/env python
"""
Provisions Apache Drill on all Mesos worker nodes and launches qsf.py via Marathon.

Usage: 
     
    ./dromedar.py $MARATHON_URL

Example: 
     
    ./dromedar.py http://localhost:8080


@author: Michael Hausenblas, http://mhausenblas.info/#i
@since: 2015-04-12
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


def launch_qsf(marathon_url):
    logging.info('Launching QSF using %s' %(marathon_url))

    # launch via Marathon REST API
    c = MarathonClient(marathon_url)
    c.create_app('dromedar-qsf', MarathonApp(cmd='qsf.py', mem=100, cpus=1))
    
    logging.info('QSF up and running.')
    
################################################################################
# Main script
#
if __name__ == '__main__':
    try:
        marathon_url = sys.argv[1] # Marathon URL to use
        launch_qsf(marathon_url)
    except Exception, e:
        print(e)
        print(__doc__)
        sys.exit(2)