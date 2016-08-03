# General Usage Guide

Docker build layers of the container.

![Weblogic Layer](https://raw.githubusercontent.com/bzon/docker-oracle-weblogic/master/img/weblogic.png)

### Requirement

Register an oracle account for free in https://www.oracle.com/downloads/index.html

You will need it to download the Oracle installer binaries as you follow the steps.

### [**Layer 1**] Oracle JDK

Build  `oracle/jdk:8` based from [**Layer 0**] `oraclelinux`

Follow the steps [here] (https://github.com/bzon/docker-oracle-weblogic/tree/master/OracleJDK)

### [**Layer 2**] Oracle Weblogic Server

Build `oracle/weblogic:12.1.3-developer` base image from here [here] (https://github.com/bzon/docker-oracle-weblogic/tree/master/OracleWeblogic/dockerfiles)

Example: Run `./buildDockerImage.sh -v 12.2.1 -d` to build a developer installation type weblogic image.

### [**Layer 3**] Oracle Weblogic Server with Domain

Build `1221-domain` image based from the `oracle/weblogic:12.1.3-developer`.

Follow the steps [here] (https://github.com/bzon/docker-oracle-weblogic/tree/master/OracleWeblogic/weblogic-samples/1221-domain)

### [**Layer 4**] Oracle Weblogic Server Domain with Sample Application and JMS configuration.

Build the sample `1221-app-jms-domain` image based from the `1221-domain` image.

Follow the steps [here] (https://github.com/bzon/docker-oracle-weblogic/tree/master/OracleWeblogic/weblogic-samples/1221-domain-app-jms)
