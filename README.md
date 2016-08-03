# General Usage Guide

Docker build layers of the container.

![Weblogic Layer](https://raw.githubusercontent.com/bzon/docker-oracle-weblogic/master/img/weblogic.png)

### [**Layer 1**] Oracle JDK

Build  `oracle/jdk:8` based from [**Layer 0**] `oraclelinux`

### [**Layer 2**] Oracle Weblogic Server

Build `oracle/weblogic:12.1.3-developer` base image

### [**Layer 3**] Oracle Weblogic Server with Domain

Build `1221-domain` image based from the `oracle/weblogic:12.1.3-developer`.

### [**Layer 4**] Oracle Weblogic Server Domain with Sample Application and JMS configuration.

Build the sample `1221-app-jms-domain` image based from the `1221-domain` image.
