Run it for TEST from .  directory

ansible-playbook --check [role].yml -i inventory --vault-password-file roles/LB/vars/vault_pass


Run it for PROD from . directory

ansible-playbook  [role].yml -i inventory --vault-password-file roles/LB/vars/vault_pass


################## Roles

default - default user creation and software install

LB - Load balancer installation with HAproxy

swarm_manages - Doker swarm manager role


##################
files/ - static configs
vars/ - dynamic configs data
templates/ - rules for dynamic config generation
