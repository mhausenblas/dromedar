# Dromedar: Drill on Mesos

This is a simple wrapper/enabler for running [Apache Drill](http://drill.apache.org/) on [Apache Mesos](http://mesos.apache.org/).

Dromedar (DRill On MEsos aDAptoR) gets launched via [Marathon](https://github.com/mesosphere/marathon/) and whenever a query request comes in, it launches a number of Drillbits, depending on the dataset size under query. The query-scale-factor (QSF) determines how many Drillbits are launched in relation to the dataset size and defaults to 1 Drillbit per 100MB (1:100) or `qsf=100`, for short.

Dromedar's architecture is as follows:

    +----------------+ +----------------------------------------+                     
    | Marathon       | |  Mesos Worker node                     |                     
    |                | |                                        |                     
    |                | |       +-------------------------+      |                     
    |                | |       |                         |      |                     
    |                | |       |        Drillbit         <---------[4]-------> SQL client
    |                | |       +------------+------------+      |                     
    |                | |                   [3]                  |                     
    |                | |       +------------+------------+      |                     
    |                | |       |                         |      |                     
    |                +----[3]-->   launch-drillbit.sh    |      |                     
    |                | |       +-------------------------+      |                     
    |                | |                                        |                     
    |                | |                                        |                     
    |                | |       +-------------------------+      |                     
    |                | |       |                         |      |                     
    |                | |HTTP API                         |      |                     
    |                <----[2]--+         qsf.py          <---------[1]-------- [QSF]  
    |                | |       |                         |      |                     
    |                | |       +-------------------------+      |                     
    +----------------+ +----------------------------------------+                     

Dromedar's underlying long-runing service is `qsf.py` is (which is initially deployed, using Marathon):

1. As an input it takes a QSF (and the URL for Marathon)
1. It uses the Marathon [HTTP API](https://mesosphere.github.io/marathon/docs/rest-api.html) to trigger on-demand Drillbits creation
1. Marathon deploys, triggered by a `qsf.py` request, an instance of `launch-drillbit.sh` which in turn launches 1 or more Drillbits
1. The SQL client connects to a Drillbit and executes a query

## Dependencies

* Apache [Drill 0.8.0](http://getdrill.org/drill/download/apache-drill-0.8.0.tar.gz)
* Apache [Mesos 0.22.x](http://archive.apache.org/dist/mesos/0.22.0/mesos-0.22.0.tar.gz)
* [Marathon 0.8.1](https://downloads.mesosphere.io/marathon/v0.8.1/marathon-0.8.1.tgz)
* [marathon-python](https://github.com/thefactory/marathon-python)

## Usage

### Install

    $ ./setup.sh

### Run

TBD

## To Do

- [x] Bootstrap (install Drill, launch Dromedar via Marathon)
- [ ] Worker deployment
- [ ] HAProxy?
- [ ] QSF implementation
- [ ] Playa test
- [ ] Cluster test
- [ ] Doc, examples, video
