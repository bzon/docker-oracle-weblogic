# LICENSE CDDL 1.0 + GPL 2.0
#
# Copyright (c) 1982-2016 Oracle and/or its affiliates. All rights reserved.
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
# This is the Dockerfile for Oracle Database 11g Release 2 Express Edition
#
# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# (1) oracle-xe-11.2.0-1.0.x86_64.rpm.zip
#     Download Oracle Database 11g Release 2 Express Edition for Linux x64
#     from http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Put the downloaded file in the same directory as this Dockerfile
# Run:
#      $ docker build -t oracle/database:11.2.0.2-xe .
#
# IMPORTANT
# ---------
# Oracle XE requires Docker 1.10.0 and above:
# Oracle XE uses shared memory for MEMORY_TARGET and needs at least 1 GB.
# Docker only supports --shm-size since Docker 1.10.0
#
# Pull base image
# ---------------
FROM oraclelinux:latest

# Maintainer
# ----------
MAINTAINER Gerald Venzl <gerald.venzl@oracle.com>


# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
ENV ORACLE_BASE=/u01/app/oracle \
    ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe/ \
    ORACLE_SID=XE \
    INSTALL_FILE_1="oracle-xe-11.2.0-1.0.x86_64.rpm.zip" \
    INSTALL_DIR="$HOME/install" \
    CONFIG_RSP="xe.rsp" \
    RUN_FILE="runOracle.sh"

# Use second ENV so that variable get substituted
ENV PATH=$ORACLE_HOME/bin:$PATH

# Oracle password
ARG ORACLE_PWD

# Copy binaries
# -------------
COPY $INSTALL_FILE_1 $CONFIG_RSP $INSTALL_DIR/

# Update yum
# ----------
RUN yum -y install unzip libaio bc initscripts net-tools && \
    yum clean all

WORKDIR $INSTALL_DIR

# Install Oracle Express Edition Package
# ------------------------------
RUN unzip $INSTALL_FILE_1 && \
    rm $INSTALL_FILE_1 &&    \
    rpm -i Disk1/*.rpm
#    rm Disk1/*.rpm

COPY $RUN_FILE $ORACLE_BASE/

EXPOSE 1521 8080

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

