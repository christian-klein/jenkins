FROM jenkins/jenkins:latest

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

USER root

# Install Ansible (+deps) from git repo & cleanup
ENV ANSIBLE_HOME=/opt/ansible

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update; \
    apt-get install --no-install-recommends -qqy \
                    build-essential \
                    libssl-dev \
                    libffi-dev \
                    cargo \
                    python3 \
                    python3-dev \
                    python3-pip \
                    python3-setuptools; \
    pip3 install ansible

USER jenkins

ENV ANSIBLE_HOME=/opt/ansible \
    PATH=$ANSIBLE_HOME/bin:$PATH \
    PYTHONPATH=$ANSIBLE_HOME/lib:$PYTHONPATH \
    MANPATH=$ANSIBLE_HOME/docs/man:$MANPATH

VOLUME ["/var/jenkins_home", "/var/run/docker.sock", "/etc/ansible"]