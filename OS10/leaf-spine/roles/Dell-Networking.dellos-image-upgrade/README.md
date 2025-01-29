Software image upgrade/install role
===================================

This role facilitates upgrades or installation of a dellos10 software image. The *dellos-image-upgrade* role requires an SSH connection for connectivity to a Dell EMC Networking device. You can use any of the built-in OS connection variables .

Installation
------------

    ansible-galaxy install Dell-Networking.dellos-image-upgrade

Role variables
--------------

- Setting an empty value for any variable negates the corresponding configuration
- Variables and values are case-sensitive

**dellos_image_upgrade keys**

| Key        | Type                      | Description                                             | Support               |
|------------|---------------------------|---------------------------------------------------------|-----------------------|
| ``operation_type``   | string: cancel,install | Displays the type of image operation | dellos10 |
| ``number_of_retries`` | integer | Specifies the number of attempts to poll the device when image installation is in progress. | dellos10 |
| ``software_image_url`` | string          | Configures the URL path to the image file | dellos10 |
| ``software_version`` | string         | Displays the software version of the image file | dellos10 |
                                                                                                      
Connection variables
--------------------

Ansible Dell EMC Networking roles require connection information to establish communication with the nodes in your inventory. This information can exist in the Ansible *group_vars* or *host_vars* directories or inventory or in the playbook itself.

| Key         | Required | Choices    | Description                                         |
|-------------|----------|------------|-----------------------------------------------------|
| ``ansible_host`` | yes      |            | Specifies the hostname or address for connecting to the remote device over the specified transport |
| ``ansible_port`` | no       |            | Specifies the port used to build the connection to the remote device; if value is unspecified, the ANSIBLE_REMOTE_PORT option is used; it defaults to 22 |
| ``ansible_ssh_user`` | no       |            | Specifies the username that authenticates the CLI login for the connection to the remote device; if value is unspecified, the ANSIBLE_REMOTE_USER environment variable value is used  |
| ``ansible_ssh_pass`` | no       |            | Specifies the password that authenticates the connection to the remote device.  |
| ``ansible_become`` | no       | yes, no\*   | Instructs the module to enter privileged mode on the remote device before sending any commands; if value is unspecified, the ANSIBLE_BECOME environment variable value is used, and the device attempts to execute all commands in non-privileged mode |
| ``ansible_become_method`` | no       | enable, sudo\*   | Instructs the module to allow the become method to be specified for handling privilege escalation; if value is unspecified, the ANSIBLE_BECOME_METHOD environment variable value is used. |
| ``ansible_become_pass`` | no       |            | Specifies the password to use if required to enter privileged mode on the remote device; if ``ansible_become`` is set to no this key is not applicable. |
| ``ansible_network_os`` | yes      | dellos6/dellos9/dellos10, null\*  | This value is used to load the correct terminal and cliconf plugins to communicate with the remote device. |

> **NOTE**: Asterisk (\*) denotes the default value if none is specified.

Dependencies
------------

The *dellos-image-upgrade* role is built on modules included in the core Ansible code. These modules were added in Ansible version 2.4.0.

Example playbook
----------------

This example uses the *dellos-image-upgrade* role to upgrade/install software image. It creates a *hosts* file with the switch details, corresponding *host_vars* file, and a simple playbook that references the *dellos-image-upgrade* role.

**Sample hosts file**

    leaf1 ansible_host= <ip_address> 

**Sample host_vars/leaf1**

    hostname: leaf1
    ansible_ssh_user: xxxxx
    ansible_ssh_pass: xxxxx
    ansible_network_os: dellos10
    dellos_image_upgrade:
      operation_type: install
      number_of_retries: 50
      software_image_url: tftp://10.16.148.8/PKGS_OS10-Enterprise-10.2.9999E.5790-installer-x86_64.bin
      software_version: 10.2.9999E

**Simple playbook to setup system - leaf.yaml**

    - hosts: leaf1
      roles:
         - Dell-Networking.dellos-image-upgrade
                
**Run**

    ansible-playbook -i hosts leaf.yaml

(c) 2017 Dell EMC
