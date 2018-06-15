#####
Requirements:

dialog console utility (yum|apt-get install dialog)

#####
Run it for TEST from .  directory

ansible-playbook --check [role].yml -i inventory --vault-password-file roles/LB/vars/vault_pass


Run it for PROD from . directory

ansible-playbook  [role].yml -i inventory --vault-password-file roles/LB/vars/vault_pass


################## Roles

default - default user creation and software install

LB - Load balancer installation with HAproxy

swarm_manages - Doker swarm manager role

containerization - Deploy and Update swarm service 

nodes - Create new AWS EC2 nodes

##################
files/ - static configs
vars/ - dynamic configs data
templates/ - rules for dynamic config generation


##################

TODO:

1 Add GlusterFS servers into Swarm nodes for Docker Volumes (by shared EC2 volume)
2 Add Draining support into run.sh for dedicated swarm managers enabling
3 Add Node role with adding AWS EC2 instances
