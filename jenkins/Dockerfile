FROM jenkins/jenkins:lts

# Fix to add docker executor in jenkins container
USER root
RUN apt-get update && apt-get install docker.io -qy
USER jenkins
