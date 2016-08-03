# Overview

This is a sample project that extends the base Weblogic domain image to have:

1. A sample.war deployed into it.
2. A datasource/jms configuration.

## Requirement

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
	
## Quickstart Guide using Docker compose
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
- Option B - Connecting weblogic container to a MySQL database

	- Deploy MySQL
	```bash
	docker run --name mysql \
		-e MYSQL_ROOT_PASSWORD=root \
		-e MYSQL_USER=mysql \
		-e MYSQL_PASSWORD=mysqlpwd \
		-e MYSQL_DATABASE=dockerdb \
		-p 3306:3306 \
		-d mysql:5.7
	```
	- Deploy Weblogic and link it to MySQL
	```bash
	docker run --name adminserver \
		-e DS_NAME="mysqlds" \
		-e DS_DB_TYPE="mysql" \
		-e DS_DB_NAME="dockerdb" \
		-e DS_JNDI_NAME="jdbc/MySqlDS" \
		-e DS_JDBC_DRIVER="com.mysql.jdbc.Driver" \
		-e DS_DB_HOST="mysql" \
		-e "DS_DB_USER=root" \
		-e DS_JDBC_URL="jdbc:mysql://mysql:3306/dockerdb" \
		-e DS_DB_PASSWORD="root" \
		-e DS_DB_PORT="3306" \
		-p 8001:8001 \
		-d 1221-app-jms-doain
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
Administrator User | weblogic
Administrator Password | Your administrator defined password from here [Building the Domain image] (https://github.com/bzon/docker-oracle-weblogic/tree/master/weblogic-samples/1221-domain
Administrator URL | http://<your.host.ip>:8001/console/
Sample WebApplication | http://<your.host.ip>:8001/sample/
