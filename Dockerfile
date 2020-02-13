# Dockerfile to create a Jenkins image with Docker CE installed for building images as part of a Jenkins job workflow

# Build the image
# docker image build -t jmshum/jenkins-with-docker .

# Run the container
# docker container run --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --rm jmshum/jenkins-with-docker

# Based on the Docker install instructions -> https://docs.docker.com/install/linux/docker-ce/debian/

FROM jenkins/jenkins

USER root

RUN apt-get update \
    && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    rm -rf /var/lib/apt/lists/*

# Adding default user 'jenkins' to the 'docker' group and givng docker.sock permissions
RUN usermod -aG docker jenkins