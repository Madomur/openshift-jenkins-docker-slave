FROM centos/python-36-centos7

MAINTAINER Martin Delbrück <info@martindelbrueck.de>

USER root

# deps for jenkins node
RUN yum-config-manager --disable centos-sclo-rh centos-sclo-sclo && yum -y update && yum install -y java-1.8.0-openjdk-headless openssh-client git && yum clean all &&\
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    useradd -ms /bin/bash jenkins && \
    usermod -aG docker jenkins

USER jenkins

ADD agent.jar ./

CMD java -jar ./agent.jar -jnlpUrl http://jenkins:8080/computer/oc/slave-agent.jnlp -workDir "/tmp/jenkins"
