# Oracle Weblogic on Docker!

An extension of the [Oracle official Weblogic docker project] (https://github.com/oracle/docker-images/OracleWeblogic).

![Docker](https://raw.githubusercontent.com/bzon/docker-oracle-weblogic/master/img/docker.png)

## Quickstart Reference

Install docker engine and docker compose and follow this [quick start guide](https://github.com/bzon/docker-oracle-weblogic/tree/master/OracleWeblogic/weblogic-samples/1221-app-jms-domain#quickstart-run-guide) to have a fully running stack in minutes.

## General Usage Guide

Follow the step by step (layer by layer) to create, build and run your own weblogic image. For your reference, the following figure shows the application layer of what you will build.

![Weblogic Layer](https://raw.githubusercontent.com/bzon/docker-oracle-weblogic/master/img/weblogic.png)

## Docker Build Requirement

Register an oracle account for free in https://www.oracle.com/downloads/index.html

You will need it to download the Oracle installer binaries as you follow the steps.

## [**Layer 1**] Oracle JDK

1. Download the Oracle JDK 8 installer.

2. Build  `oracle/jdk:8` based from [**Layer 0**] `oraclelinux`

Follow the steps [here] (https://github.com/bzon/docker-oracle-weblogic/tree/master/OracleJDK)

## [**Layer 2**] Oracle Weblogic Server

1. Download the Weblogic installer.

2. Build `oracle/weblogic:12.2.1-developer` base image from [here] (https://github.com/bzon/docker-oracle-weblogic/tree/master/OracleWeblogic/dockerfiles)

Example: Run `./buildDockerImage.sh -v 12.2.1 -d` to build a developer installation type weblogic image.

## [**Layer 3**] Oracle Weblogic Server with Domain

Build `1221-domain` image based from the `oracle/weblogic:12.1.3-developer`.

Follow the steps [here] (https://github.com/bzon/docker-oracle-weblogic/tree/master/OracleWeblogic/weblogic-samples/1221-domain)

## [**Layer 4**] Oracle Weblogic Server Domain with Sample Application or with App and JMS configuration.

Option 1 - Build the sample `1221-appdeploy` image based from the `1221-domain` image.

Follow the steps [here] (https://github.com/bzon/docker-oracle-weblogic/tree/master/OracleWeblogic/weblogic-samples/1221-appdeploy)

Option 2 - Build the sample `1221-app-jms-domain` image based from the `1221-domain` image.

Follow the steps [here] (https://github.com/bzon/docker-oracle-weblogic/tree/master/OracleWeblogic/weblogic-samples/1221-app-jms-domain)
