Authentication Authorization Accounting or AAA in abbreviation is one of the necessary functions or services in every network on the management plane.
As a network manager, you must define each admin and operator's credentials (Authentication), define access scope and allowed commands for each account (Authorization), and finally logs each command that the admin runs on network devices (Accounting).
You can use TACACS+ or RADIUS, two popular protocols to implement this functionality.
One of the simplest and most powerful protocols to implement AAA is TACACS+ protocol.
In this project, we use the latest version (F4.0.4.28) of Shrubbery Networks's TACACS+ daemon on Ubuntu 24.04 in two ways:
- Docker image to dockerize this service
- on-premise service to install on a dedicated server.

First to create a docker image:
1) Use Dockerfile to create a docker image: 
  $ sudo docker build --tag tacacsplus .
3) Create a docker volume to copy the config file and export accounting logs: 
   $ sudo docker volume create tacacs_vol
4) Run docker container: 
   $ sudo docker run -d --name tacacsplus -p 49:49/tcp --mount src=tacacs_vol,dst=/etc/tac_plus tacacsplus
5) Copy the config file to the docker container: 
   $ sudo docker cp ./tac_plus.conf tacacsplus:/etc/tac_plus/tac_plus.conf
6) Restart the docker container to restart the service with the new configuration file: 
   $ sudo docker restart tacacsplus

You can create a config file with help on sample tac_plus.conf
You can pull a docker image with this command:
 $ sudo docker pull jsonwalt/tacacsplus

If you are subject to sanctions and can not pull the docker image directly from hub.docker.com/jsonwalt you can download the image from the link and import it manually.
- To download the image:
  https://mega.nz/file/3IhQwDbY#TBgRuMBIYRsMzy1fTHXArOsK8F1JGDLgvJHJwGgQJds
- To import images:
  $ sudo docker load -i jsonwalt-tacacsplus.tar
