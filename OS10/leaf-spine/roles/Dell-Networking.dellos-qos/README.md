QoS role
========

This role facilitates the configuration quality of service (QoS) attributes like policy-map and class-map. This role is abstracted for dellos10. The QoS role requires an SSH connection for connectivity to a Dell EMC Networking device. You can use any of the built-in OS connection variables .

Installation
------------

    ansible-galaxy install Dell-Networking.dellos-qos

Role variables
--------------

- Role is abstracted using the *ansible_network_os* variable that can take a dellos10 value
- If *dellos_cfg_generate* is set to true, the variable generates the role configuration commands in a file
- Any role variable with a corresponding state variable set to absent negates the configuration of that variable 
- Setting an empty value for any variable negates the corresponding configuration
- Variables and values are case-sensitive

**dellos_qos keys**

| Key        | Type                      | Description                                             | Support               |
|------------|---------------------------|---------------------------------------------------------|-----------------------|
| ``policy_map`` | list | Configures the policy-map (see ``policy_map.*``) | dellos10 |
| ``policy_map.name`` | string (required)        | Configures the policy-map name  | dellos10 |
| ``policy_map.type`` | string: qos\*,application,control-plane,network-qos,queuing    | Configures the policy-map type  | dellos10 |
| ``policy_map.state`` | string: present\*,absent   | Deletes the policy-map if set to absent  | dellos10 |
| ``class_map`` | list | Configures the class-map (see ``class_map.*``) | dellos10 |
| ``class_map.name`` | string (required)        | Configures the class-map name  | dellos10 |
| ``class_map.type`` | string: qos\*,application,control-plane,network-qos,queuing    | Configures the class-map type  | dellos10 |
| ``class_map.state`` | string: present\*,absent   | Deletes the class-map if set to absent  | dellos10 |

> **NOTE**: Asterisk (\*) denotes the default value if none is specified. 

Connection variables
--------------------

Ansible Dell EMC Networking roles require connection information to establish communication with the nodes in your inventory. This information can exist in the Ansible *group_vars* or *host_vars* directories, or inventory or in the playbook itself.

| Key         | Required | Choices    | Description                                         |
|-------------|----------|------------|-----------------------------------------------------|
| ``ansible_host`` | yes      |            | Specifies the hostname or address for connecting to the remote device over the specified transport |
| ``ansible_port`` | no       |            | Specifies the port used to build the connection to the remote device; if value is unspecified, the ANSIBLE_REMOTE_PORT option is used; it defaults to 22 |
| ``ansible_ssh_user`` | no       |            | Specifies the username that authenticates the CLI login for the connection to the remote device; if value is unspecified, the ANSIBLE_REMOTE_USER environment variable value is used  |
| ``ansible_ssh_pass`` | no       |            | Specifies the password that authenticates the connection to the remote device |
| ``ansible_become`` | no       | yes, no\*   | Instructs the module to enter privileged mode on the remote device before sending any commands; if value is unspecified, the ANSIBLE_BECOME environment variable value is used, and the device attempts to execute all commands in non-privileged mode |
| ``ansible_become_method`` | no       | enable, sudo\*   | Instructs the module to allow the become method to be specified for handling privilege escalation; if value is unspecified, the ANSIBLE_BECOME_METHOD environment variable value is used |
| ``ansible_become_pass`` | no       |            | Specifies the password to use if required to enter privileged mode on the remote device; if ``ansible_become`` is set to no this key is not applicable |
| ``ansible_network_os`` | yes      | dellos6/dellos9/dellos10, null\*  | Loads the correct terminal and cliconf plugins to communicate with the remote device |

> **NOTE**: Asterisk (\*) denotes the default value if none is specified.

Dependencies
------------

The *dellos-qos* role is built on modules included in the core Ansible code. These modules were added in Ansible version 2.2.0.

Example playbook
----------------

This example uses the *dellos.dellos-qos* role to configure the policy-map class-map. It creates a *hosts* file with the switch details and corresponding variables. The hosts file should define the *ansible_network_os* variable with corresponding Dell EMC networking OS name. 

When *dellos_cfg_generate* is set to true, the variable generates the configuration commands as a .part file in *build_dir* path. By default, the variable is set to false. It writes a simple playbook that only references the *dellos-qos* role. By including the role, you automatically get access to all of the tasks to configure QoS features. 

**Sample hosts file**
 
    leaf1 ansible_host= <ip_address> 

**Sample host_vars/leaf1**

    hostname: leaf1
    ansible_ssh_user: xxxxx
    ansible_ssh_pass: xxxxx
    ansible_network_os: dellos10
    build_dir: ../temp/dellos10
	  
    dellos_qos:
      policy_map:
       - name: testpolicy
         type: qos
         state: present
      class_map:
       - name: testclass
         type: application
         state: present
     
**Simple playbook to setup qos - leaf.yaml**

    - hosts: leaf1
      roles:
         - Dell-Networking.dellos-qos

**Run**

    ansible-playbook -i hosts leaf.yaml

(c) 2017 Dell Inc. or its subsidiaries. All Rights Reserved.
