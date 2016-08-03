Script | Description
------------ | -------------
sample.war | A sample application to be deployed in weblogic.
app-deploy.py | WLST Offline for deploying an application under `$APP_NAME` packaged in `$APP_PKG_FILE` located in `$APP_PKG_LOCATION`. Based from Oracle sample deploy app script. Please see [Oracle Github App deploy samples] (https://github.com/oracle/docker-images/tree/master/OracleWebLogic/samples/1221-appdeploy/container-scripts) for more information.
datasource.properties | A tokenised template properties file for connecting weblogic to a database. Works with the script deployDataSource.sh. Please see [Oracle Github adding resources samples] (https://github.com/oracle/docker-images/tree/master/OracleWebLogic/samples/1221-domain-with-resources/container-scripts) for more information.
ds-deploy.py | Please see [Oracle Github adding resources samples] (https://github.com/oracle/docker-images/tree/master/OracleWebLogic/samples/1221-domain-with-resources/container-scripts) for more information.
jms-deploy.py | Please see [Oracle Github adding resources samples] (https://github.com/oracle/docker-images/tree/master/OracleWebLogic/samples/1221-domain-with-resources/container-scripts) for more information.
deployDataSource.sh | A shell script that replaces tokens in the datasource.properties file. This script is created to be able to connect weblogic into different database type or different database values.
entrypoint.sh | A shell script that runs initially when the container is ran.
wait-for-it.sh | A shell script that waits for a service to be available. It is currently used for waiting a database service. Source [Vishnubob Wait for it](https://github.com/vishnubob/wait-for-it)


