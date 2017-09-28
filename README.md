# Dell EMC Networking Ansible Module Examples
Use these sample Ansible playbooks to better understand how to use Dell EMC Networking Ansible modules.

## Installation and setup

**1**. Install Ansible (see [Ansible documentation](http://docs.ansible.com/ansible/intro_installation.html)).

**2**. Clone this repository in the Control Machine (see [Notes](#notes)).

**3**. Update the ``inventory.yaml`` file to configure the device IP.

**4**. Update the corresponding host variables (``hosts_var/dellos10_sw1.yaml``) for device credentials.


## Dell EMC Networking OS6

dellos6_facts module example — collects the facts from the OS6 device.

    ansible-playbook -i inventory.yaml getfacts_os6.yaml

dellos6_command module example — executes the ``show version`` command.

  ansible-playbook -i inventory.yaml showver_os6.yaml

dellos6_config module example — configures the hostname for the OS6 device.

    ansible-playbook -vvv -i inventory.yaml hostname_os6.yaml

## Dell EMC Networking OS9

dellos9_facts module example — collects the facts from the OS9 device.

    ansible-playbook -i inventory.yaml getfacts_os9.yaml

dellos9_command module example — executes the show version command.

    ansible-playbook -i inventory.yaml showver_os9.yaml

dellos9_config module example — configures the hostname for the OS9 device.

    ansible-playbook -vvv -i inventory.yaml hostname_os9.yaml

## Dell EMC Networking OS10

dellos10_facts module example — collects the facts from the OS10 device.

    ansible-playbook -i inventory.yaml getfacts_os10.yaml

dellos10_command module example — executes the show version command.

    ansible-playbook -i inventory.yaml showver_os10.yaml

dellos10_config module example — configures the hostname for the OS10 device.

    ansible-playbook -vvv -i inventory.yaml hostname_os10.yaml

## Notes
- For Ansible 2.4 and devel, use master branch
- For Ansible 2.3 and older, use release tag 1.0.0

## Contact
Send general comments and feedback to feedback-ansible-dell-networking@dell.com.

© 2017 Dell EMC
