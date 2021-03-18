# Jenkins docker container with Ansible installed

This will extend the Jenkins/Jenkins container and install Ansible in it. Ansible playbooks can then be used to auto deploy new build artifacts to the environment.

The `plugins.txt` file can be adjusted to add more pre-installed Jenkins plugins.

The host docker instance will be used within the container.

Included is an example `docker-compose.yml` with an NFS mounted jenkins home directory. Replace `MY.REGISTRY` with your registry holding the built jenkins container image and `NFS.SERVER` with your NFS server.
