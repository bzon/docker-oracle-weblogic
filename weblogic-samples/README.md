# Example Image of Weblogic Domain with a Deployed Application and JMS resources

## Building the Image
----
- Build using the default/sample application 
	```bash
	docker build -t 1221-app-jms-domain .
	```

- Build using a custom application, *imagine* you have a helloWorld application and you put the war file under container-scripts directory

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

### Provisioning the Docker way stack topology
----
- Launch the stack

	```bash
	docker-compose -f compose-dockerway/docker-compose.yml up -d
	```

- Scaling the AdminServer (Optional)
	
	```bash
	docker-compose scale adminserver=3
	```

### Provisioning using Docker 1.12

```bash
docker run -it -d -p 5000:5000 -e HOST=${PUBLIC_HOSTNAME} -e PORT=5000 -v /var/run/docker.sock:/var/run/docker.sock manomarks/visualizer
```

```bash
# Create docker network
docker network create demonet -d overlay

# Create myqsl service
docker service create --name mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_USER=mysql -e MYSQL_PASSWORD=mysqlpwd -e MYSQL_DATABASE=dockerdb -p 3306:3306 --network demo mysql:5.7

# Create weblogic service
docker service create --name adminserver -e DS_NAME="mysqlds" -e DS_DB_TYPE="mysql" -e DS_DB_NAME="dockerdb" -e DS_JNDI_NAME="jdbc/MySqlDS" -e DS_JDBC_DRIVER="com.mysql.jdbc.Driver" -e DS_DB_HOST="mysql" -e "DS_DB_USER=root" -e DS_JDBC_URL="jdbc:mysql://mysql:3306/dockerdb" -e DS_DB_PASSWORD="root" -e DS_DB_PORT="3306" -p 8001:8001 --network demo dockerhub.accenture.com/adop-afpo/oracle-weblogic:1221-app-jms-domain
```

### How to Access your environment
----
Using your web browser, navigate to `http://<your.host.ip>/console` and login using `weblogic/welcome1`.  
Navigate to `http://<your.host.ip>/sample` to view the sample application.
