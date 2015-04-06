# Dromedar: Drill on Mesos

This is a simple wrapper/enabler for running [Apache Drill](http://drill.apache.org/) on [Apache Mesos](http://mesos.apache.org/).

Dromedar (DRill On MEsos aDAptoR) gets launched via [Marathon](https://github.com/mesosphere/marathon/) and whenever a query request comes in, it launches a number of Drillbits, depending on the dataset size under query. The query-scale-factor determines how many Drillbits are launched and defaults to 1 Drillbit per 100MB (1:100) or `qfs=100` for short.


## Dependencies

* Apache [Drill 0.8.0](http://getdrill.org/drill/download/apache-drill-0.8.0.tar.gz)
* Apache [Mesos 0.22.x](http://archive.apache.org/dist/mesos/0.22.0/mesos-0.22.0.tar.gz)
* [Marathon 0.8.1](https://downloads.mesosphere.io/marathon/v0.8.1/marathon-0.8.1.tgz)
* [marathon-python](https://github.com/thefactory/marathon-python)

## Usage

### Install

### Run