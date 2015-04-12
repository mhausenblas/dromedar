# Dromedar: Drill on Mesos

This is a simple wrapper/enabler for running [Apache Drill](http://drill.apache.org/) on [Apache Mesos](http://mesos.apache.org/).

Dromedar (DRill On MEsos aDAptoR) gets launched via [Marathon](https://github.com/mesosphere/marathon/) and whenever a query request comes in, it launches a number of Drillbits, depending on the dataset size under query. The query-scale-factor (QSF) determines how many Drillbits are launched in relation to the dataset size and defaults to 1 Drillbit per 100MB (1:100) or `qsf=100`, for short.

Dromedar's architecture is as follows:

    +----------------+ +----------------------------------------+                     
    | Marathon       | |  Mesos worker node                     |                     
    |                | |                                        |                     
    |                | |       +-------------------------+      |                     
    |                | |       |                         |      |                     
    |                | |       |        Drillbit         <---------[3]-------> SQL client
    |                | |       +------------+------------+      |                     
    |                | |                   [2]                  |                     
    |                | |       +------------+------------+      |                     
    |                | |       |                         |      |                     
    |                +----[2]-->    drillbit.sh start    |      |                     
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

Dromedar's underlying long-runing service is `qsf.py` which itself is initially deployed through `dromedar.py`, using Marathon. Once `qsf.py` is running as a Web service it performs the following steps:

1. As an input it takes a QSF via its HTTP interface on port `9876`.
1. It uses the Marathon [HTTP API](https://mesosphere.github.io/marathon/docs/rest-api.html) to trigger on-demand Drillbits creation using the `drillbit.sh start` command.
1. The SQL client connects to (one of) the Drillbit(s) and executes the SQL query.

## Dependencies

* Apache [Mesos 0.22.x](http://archive.apache.org/dist/mesos/0.22.0/mesos-0.22.0.tar.gz)
* [Marathon 0.8.1](https://downloads.mesosphere.io/marathon/v0.8.1/marathon-0.8.1.tgz)
* Apache [Drill 0.8.0](http://getdrill.org/drill/download/apache-drill-0.8.0.tar.gz)
* [marathon-python](https://github.com/thefactory/marathon-python)

Note that Apache Drill and the Marathon Python package are installed via Dromedar, directly. The only two things that are assumed to be available are Mesos and Marathon itself.

## Usage

    $ ./launch.sh

Then, go to the Marathon UI where you should see something like the following:

![Dromedar launched in Marathon](doc/dromedar-launched.png)


## To Do

- [x] Bootstrap (install Drill, launch Dromedar via Marathon)
- [ ] Strata implementation cross-check
- [ ] Playa testing
- [ ] Cluster testing
- [ ] HAProxy deployment?
- [ ] Doc, examples, video
