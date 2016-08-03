# This Dockerfile will build a weblogic image that can contain a sample application and resources
# To deploy a different application (war file), place your custom war files under container-scripts/
# and set --build-arg APP_NAME=<custom app name> --build-arg APP_PKG_FILE=<custom war file>

FROM 1221-domain 

MAINTAINER John Bryan Sazon <john.bryan.j.sazon@accenture.com>

# Define Application build arguments (editable on build time)
ARG APP_NAME
ARG APP_PKG_FILE

# Define variables
ENV APP_NAME="${APP_NAME:-sample}" \
    APP_PKG_FILE="${APP_PKG_FILE:-sample.war}" \
    APP_PKG_LOCATION="/u01/oracle"

# Copy files and deploy application in WLST Offline mode
COPY container-scripts/* /u01/oracle/
RUN wlst /u01/oracle/app-deploy.py

# Set default datasource values thru environment variables
ENV DS_NAME="DockerDS" \
    DS_DB_NAME="default;create=true" \
    DS_JNDI_NAME="jdbc/DockerDS" \
    DS_JDBC_DRIVER="org.apache.derby.jdbc.ClientDataSource" \
    DS_JDBC_URL="jdbc:derby://localhost:1527/default;ServerName=localhost;databaseName=default;create=true" \
    DS_DB_HOST="localhost" \
    DS_DB_PORT="1527" \
    DS_DB_USER="" \
    DS_DB_PASSWORD="" \
    DS_MAX_CAPACITY="1"

ENTRYPOINT ["/u01/oracle/entrypoint.sh"]

