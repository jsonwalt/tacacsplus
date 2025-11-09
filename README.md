Authentication, Authorization Accounting or AAA in abbreviation is one of the necessary functions or services in every network on the management plane.
As a network manager, you must define each admin and operator's credentials (Authentication), define access scope and allowed commands for each account (Authorization), and finally log each command that the admin runs on network devices (Accounting).
You can use TACACS+ or RADIUS, two popular protocols to implement this functionality.
One of the simplest and most powerful protocols to implement AAA is the TACACS+ protocol.
In this project, we use the latest version (F4.0.4.28) of Shrubbery Networks' TACACS+ daemon on Ubuntu 24.04 in two ways:
- Docker image to dockerize this service
- on-premise service to install on a dedicated server.

First, to create a Docker image:
1) Use Dockerfile to create a Docker image: 
  $ sudo docker build --tag jsonwalt/tacacsplus .
3) Create a Docker volume to copy the config file and export accounting logs: 
   $ sudo docker volume create tacacs_vol
4) Run Docker container: 
   $ sudo docker run -d --name tacacsplus --restart unless-stopped -p 49:49/tcp -e "TZ=Asia/Tehran" --mount src=tacacs_vol,dst=/etc/tac_plus jsonwalt/tacacsplus
6) Copy the config file to the Docker container: 
   $ sudo docker cp ./tac_plus.conf tacacsplus:/etc/tac_plus/tac_plus.conf
7) Restart the Docker container to restart the service with the new configuration file: 
   $ sudo docker restart tacacsplus

You can create a config file with help from the sample tac_plus.conf
You can pull a Docker image with this command:
 $ sudo docker pull jsonwalt/tacacsplus

If you are subject to sanctions and can not pull the Docker image directly from https://hub.docker.com/jsonwalt, you can download the image from the link and import it manually.
- To download the image:
  https://mega.nz/file/3IhQwDbY#TBgRuMBIYRsMzy1fTHXArOsK8F1JGDLgvJHJwGgQJds
- To import images:
  $ sudo docker load -i jsonwalt-tacacsplus.tar

To edit the config file (change a user's password, create a new user, remove a user, change permissions, etc.):
1) Take a shell container:
   $ sudo docker exec -it tacacsplus /bin/bash
2) generate MD5 password:
   $ tac_pwd -m
3) edit config file:
   $ nano /etc/tac_plus/tac_plus.conf
4) exit from the container's shell:
   $ exit
5) restart the container:
   $ sudo docker restart tacacsplus
