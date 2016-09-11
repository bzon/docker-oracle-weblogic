# Overview

This is a sample project that extends the base Weblogic domain image to have:

1. A sample.war deployed into it.
2. A datasource/jms configuration.

**Before following the steps below** - Make sure that you have already have built the docker image `1221-domain`. If not, please follow the guide from [Building the Domain image] (https://github.com/bzon/docker-oracle-weblogic/tree/master/weblogic-samples/1221-domain) first!

## Building the Image
- Build using the default/sample application 
	```bash
	docker build -t 1221-app-jms-domain .
	```

- (Optional) - Build using a custom application, *imagine* you have a helloWorld application and you put the war file under container-scripts directory

	```bash
	# Your project directory structure
	├── compose-dockerway
	│--└── docker-compose.yml
	├── container-scripts
	│├── app-deploy.py
	│-- ├── datasource.properties
	│-- ├── deployDataSource.sh
	│-- ├── ds-deploy.py
	│-- ├── entrypoint.sh
	│-- ├── *helloWorld.war*
	│-- ├── jms-deploy.py
	│-- ├── sample.war
	│-- └── wait-for-it.sh
	├── Dockerfile
	└── README.md
	```

	```bash
	docker build --no-cache --rm=true --build-arg APP_NAME=helloWorld --build-arg APP_PKG_FILE=helloWorld.war -t 1221-app-jms-domain .
	```
	
## Quickstart Run Guide
Running this docker compose file creates a stack of Oracle Weblogic, MySQL Database, and an Apache Httpd container for load balancing in a single host. The design is to follow the "Docker way" topology container deployment.

Please see the [Official Oracle Weblogic Whitepaper](http://www.oracle.com/us/products/middleware/cloud-app-foundation/weblogic/weblogic-server-on-docker-wp-2742665.pdf) for more information.

### Host Requirements
- Docker Engine 1.10 or higher
- Docker Compose 1.7 or higher
- 2 CPU 8 GB RAM

### Using Docker run
- Option A - Run the weblogic container without using an external database.

	```bash
	docker run -p 8001:8001 -d 1221-app-jms-domain
	```
- Option B - Connecting weblogic container to a Oracle database

	- Deploy Oracle XE
	```bash
	 docker run --name=oracledb -d --shm-size=1g -p 1521:1521 -p 8080:8080 oracle/database:11.2.0.2-xe
	```
	- Deploy Weblogic and link it to MySQL
	```bash
	docker run --name adminserver \
           --link oracledb:oracledb \
           -e DS_NAME="Oracle" \
           -e DS_DB_TYPE="Oracle" \
           -e DS_DB_NAME="dockerdb" \
           -e DS_JNDI_NAME="jdbc/oracleDatabase" \
           -e DS_JDBC_DRIVER="oracle.jdbc.driver.OracleDriver" \
           -e DS_DB_HOST="oracledb" \
           -e DS_DB_USER="system" \
           -e DS_JDBC_URL="jdbc:oracle:thin:system/password123@oracledb:1521:XE" \
           -e DS_DB_PASSWORD="password123" \
           -e DS_DB_PORT="1521" \
           -p 8001:8001 \
           -d 1221-app-jms-domain
	```

### Using Docker compose or simplifying orchestration
- Launch the stack.

	```bash
	docker-compose up -d
	```

- Scaling (Optional)
	
	```bash
	docker-compose scale adminserver=3
	docker-compose scale mysql=2
	```
	
### Access Information

Information | Value
------------ | -------------
Administrator User | weblogic (default)
Administrator Password | welcome1 (default)
Proxied Administrator URL | http://<your.host.ip>/console/ if you used `docker-compose`
Proxied Sample WebApplication | http://<your.host.ip>/sample/ if you used `docker-compose`
Administrator URL | http://<your.host.ip>:8001/console/ if you used `docker run`
Sample WebApplication | http://<your.host.ip>:8001/sample/ if you used `docker run`
