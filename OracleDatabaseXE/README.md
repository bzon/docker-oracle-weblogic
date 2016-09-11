# Quickstart Run Guide

## Using Docker Run

1. Build Oracle XE image.  
   ```bash
   docker build -t oracle-db-11-xe .
   ```
   
2. Deploy Oracle XE.  
   ```bash
   docker run -d --shm-size=1g -e ORACLE_PWD=<password> oracle-db-11-xe
   ```
