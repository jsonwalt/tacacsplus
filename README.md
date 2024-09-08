Authentication Authorization Accounting or AAA in abbreviation is a one of nessessiest functions or services in every network on management plane.
As an network manager you must define each admins and operators credential (Authentication), define access scope and allowed commands for each account (Authorization) and finally logs each command that admin run on network devices (Accounting).
To implement this functionality you can use TACACS+ or RADIUS, two popular protocols.
One of the simplest and still powerfull protocols to implement AAA is TACACS+ protocol.
On this project we use latest version (F4.0.4.28) Shrubbery Networks's TACACS+ deamon on Ubuntu 24.04 in two ways:
- Docker image to dockerize this service
- on premise service to install on dedicated server.

First to create docker image:
1) Use Dockerfile to create docker image: 
  $ sudo docker build --tag tacacsplus .
3) Create docker volume to copy config file and export accounting logs: 
   $ sudo docker volume create tacacs_vol
4) Run docker container: 
   $ sudo docker run -d --name tacacsplus -p 49:49/tcp --mount src=tacacs_vol,dst=/etc/tac_plus tacacsplus
5) Copy config file to docker container: 
   $ sudo docker cp ./tac_plus.conf tacacsplus:/etc/tac_plus/tac_plus.conf
6) Restart docker container to restart service with new configuration file: 
   $ sudo docker restart tacacsplus

You can create config file with help on sample tac_plus.conf
