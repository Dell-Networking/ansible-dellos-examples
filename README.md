# Examples of Dell EMC Networking Ansible Modules

Use these sample Ansible playbooks to better understand how to use Dell EMC Networking Ansible modules.

## Installation and Setup

1. Install Ansible (see [Ansible documentation] (http://docs.ansible.com/ansible/intro_installation.html))
2. Clone this repository in the control machine. [Notes](#notes)
3. Update the ``inventory.yaml`` file to configure the device IP.
4. Update the corresponding host variables (for example: ``hosts_var/dellos10_sw1.yaml``) for device credentials.

## Dell EMC Networking OS6

Example for dellos6_facts module. This collects the facts from the OS6 device.

``ansible-playbook -i inventory.yaml OS6/getfacts_os6.yaml``

Example for dellos6_command module. This executes the show version command.

``ansible-playbook -i inventory.yaml OS6/showver_os6.yaml``

Example for dellos6_config module. This configures the hostname for the OS6 device.

``ansible-playbook -vvv -i inventory.yaml OS6/hostname_os6.yaml``

## Dell EMC Networking OS9

Example for dellos9_facts module. This collects the facts from the OS9 device.

``ansible-playbook -i inventory.yaml OS9/getfacts_os9.yaml``

Example for dellos9_command module. This executes the show version command.

``ansible-playbook -i inventory.yaml OS9/showver_os9.yaml``

Example for dellos9_config module. This configures the hostname for the OS9 device.

``ansible-playbook -vvv -i inventory.yaml OS9/hostname_os9.yaml``

## Dell EMC Networking OS10

Example for dellos10_facts module. This collects the facts from the OS10 device.

``ansible-playbook -i inventory.yaml OS10/getfacts_os10.yaml``

Example for dellos10_command module. This executes the show version command.

``ansible-playbook -i inventory.yaml OS10/showver_os10.yaml``

Example for dellos10_config module. This configures the hostname for the OS10 device.

``ansible-playbook -vvv -i inventory.yaml OS10/hostname_os10.yaml``

# Notes
- For Ansible 2.5 and devel, use master branch
- For Ansible 2.4, use release tag 2.0.0
- For Ansible 2.3 and older, use release tag 1.0.0

# Contact
Send general comments and feedback to: feedback-ansible-dell-networking@dell.com

(c) 2017 Dell Inc. and its subsidiaries. All Rights Reserved.
