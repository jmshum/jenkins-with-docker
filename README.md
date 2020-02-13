# Jenkins image with Docker CE installed for building images as part of a Jenkins job workflow.
This image is based on the [jenkins/jenkins](https://hub.docker.com/r/jenkins/jenkins/) image. 

Docker CE is installed based on the [Docker for linux](https://docs.docker.com/install/linux/docker-ce/debian/
) install instructions.

This image was designed for quickly testing new Jenkins job and pipeline tasks that build Docker images from source.

## Usage

### Building the Docker image
```bash
docker image build -t jmshum/jenkins-with-docker .
```

### Running the Docker image with persistent data through volumes
```bash
docker container run --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --rm jmshum/jenkins-with-docker
```

### Running the Docker image without persistent data and with minimal open ports
```bash
docker container run --name jenkins -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock --rm jmshum/jenkins-with-docker
```

### After the container is running:
* Copy Admin password from the Docker container output or from /var/jenkins_home/secrets/initialAdminPassword
* Log into Jenkins dashboard http://localhost:8080
* Enter 'admin' password
* Install plugins
* Create new job