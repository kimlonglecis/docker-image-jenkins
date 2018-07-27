#   Objectives:
    ##  1. Install Jenkins
    ##  2. Install Git
    ##  3. Install Composer
    ##  4. COPY .ssh and composer.auth files

##  1. Install Jenkins
FROM jenkins/jenkins:lts

# Install Tools
USER root
RUN apt-get update && \
    apt-get install -y \
    php \
    nano \
    vim \
    telnet \
    netcat \
    git-core \
    zip \
    openssh-server && \
    apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*
RUN apt update && \
    apt install -y nmap && \
#   Install SSHD KEY
    /usr/bin/ssh-keygen -A
#  3. Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin && \ 
    chown -R jenkins:jenkins /var/jenkins_home/
ENTRYPOINT service ssh restart && bash
USER jenkins
WORKDIR /var/jenkins_home/

## Docker image name:                           jenkins-master
## Docker Hub Image Name:                       devtutspace/jenkins-master
## Docker Image Build command:                  docker build -t jenkins-master ./
## Docker Image Build No Cache command:         docker build --no-cache -t jenkins-master ./
## Docker Image Tag command:                    docker tag jenkins-master devtutspace/jenkins-master
## Docker Image Push command:                   docker push devtutspace/jenkins-master
## DOcker Image Build, Tag, Push:               docker build -t jenkins-master ./ && \docker tag jenkins-master devtutspace/jenkins-master && docker push devtutspace/jenkins-master