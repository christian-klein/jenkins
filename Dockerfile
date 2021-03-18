FROM jenkins/jenkins:latest

# Install plugins
# RUN /usr/local/bin/install-plugins.sh \
# workface-editor:latest \
# ant:latest \
# ansible:latest \
# antisamy-markup-formatter:latest \
# apache-httpcomponents-client-4-api:latest \
# authentication-tokens:latest \
# bootstrap4-api:latest \
# bouncycastle-api:latest \
# branch-api:latest \
# build-timeout:latest \
# checks-api:latest \
# cloudbees-folder:latest \
# command-launcher:latest \
# credentials:latest \
# credentials-binding:latest \
# display-url-api:latest \
# docker-commons:latest \
# docker-workflow:latest \
# durable-task:latest \
# echarts-api:latest \
# email-ext:latest \
# font-awesome-api:latest \
# git:latest \
# git-client:latest \
# github:latest \
# github-api:latest \
# github-branch-source:latest \
# git-server:latest \
# gradle:latest \
# handlebars:latest \
# jackson2-api \
# jdk-tool:latest \
# jjwt-api:latest \
# jquery3-api:latest \
# jsch:latest \
# junit:latest \
# ldap:latest \
# lockable-resources:latest \
# low-api:latest \
# mailer:latest \
# matrix-auth:latest \
# matrix-project:latest \
# momentjs:latest \
# okhttp-api:latest \
# pam-auth:latest \
# pipeline-build-step:latest \
# pipeline-github-lib:latest \
# pipeline-graph-analysis:latest \
# pipeline-input-step:latest \
# pipeline-milestone-step:latest \
# pipeline-model-api:latest \
# pipeline-model-definition:latest \
# pipeline-model-extensions:latest \
# pipeline-rest-api:latest \
# pipeline-stage-step:latest \
# pipeline-stage-tags-metadata:latest \
# pipeline-stage-view:latest \
# plain-credentials:latest \
# plugin-util-api:latest \
# popper-api:latest \
# purge-job-history \
# resource-disposer:latest \
# scm-api:latest \
# script-security:latest \
# snakeyaml-api:latest \
# ssh:latest \
# ssh-credentials:latest \
# ssh-agent \
# ssh-slaves:latest \
# structs:latest \
# timestamper:latest \
# token-macro:latest \
# trilead-api:latest \
# workflow-aggregator:latest \
# workflow-basic-steps:latest \
# workflow-cps:latest \
# workflow-cps-global-lib:latest \
# workflow-durable-task-step:latest \
# workflow-job:latest \
# workflow-multibranch:latest \
# workflow-scm-step:latest \
# workflow-step-api:latest \
# workflow-support:latest \
# ws-cleanup \
# xunit 

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
# RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
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
        # build-essential \

        # python-pip python-dev python-yaml \
        # libffi-dev libssl-dev \
        # libxml2-dev libxslt1-dev zlib1g-dev && \

# sh 'docker build -t api.cklein.us --no-cache .'


USER jenkins

ENV ANSIBLE_HOME=/opt/ansible \
    PATH=$ANSIBLE_HOME/bin:$PATH \
    PYTHONPATH=$ANSIBLE_HOME/lib:$PYTHONPATH \
    MANPATH=$ANSIBLE_HOME/docs/man:$MANPATH

VOLUME ["/var/jenkins_home", "/var/run/docker.sock", "/etc/ansible"]