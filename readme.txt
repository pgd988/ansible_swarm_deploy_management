Run it for TEST from .  directory

ansible-playbook --check LB.yml -i inventory --vault-password-file roles/LB/vars/vault_pass


Run it for PROD from . directory

ansible-playbook  LB.yml -i inventory --vault-password-file roles/LB/vars/vault_pass


##################
files/ - static configs
vars/ - dynamic configs data
templates/ - rules for dynamic config generation
