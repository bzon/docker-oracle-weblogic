# A Weblogic Domain with a Deployed Sample Application and JMS resources

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
----
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
### How to Access your environment
----
Using your web browser, navigate to `http://<your.host.ip>/console` and login using `weblogic/welcome1`.  
Navigate to `http://<your.host.ip>/sample` to view the sample application.
