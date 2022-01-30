# Dockerfile to create a Jenkins image with Docker CE installed for building images as part of a Jenkins job workflow

# Build the image
# docker image build -t jmshum/jenkins-with-docker .

# Run the container
# docker container run --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --rm jmshum/jenkins-with-docker

# Based on the Docker install instructions -> https://docs.docker.com/engine/install/debian/

FROM jenkins/jenkins

USER root

RUN apt-get update \
    && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    rm -rf /var/lib/apt/lists/*

# Adding default user 'jenkins' to the 'docker' group and givng docker.sock permissions
RUN usermod -aG docker jenkins