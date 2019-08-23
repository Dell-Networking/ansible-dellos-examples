LAG role
========

This role facilitates the configuration of link aggregation group (LAG) attributes, and supports the creation and deletion of a LAG and its member ports. It also supports the configuration of an interface type as a static or dynamic LAG, hash scheme in dellos6 devices, and minimum required link. This role is abstracted for dellos9, dellos6, and dellos10 devices.

The LAG role requires an SSH connection for connectivity to a Dell EMC Networking device. You can use any of the built-in OS connection variables .

Installation
------------

    ansible-galaxy install Dell-Networking.dellos-lag

Role variables
--------------

- Object drives the tasks in this role
- *dellos_lag* (dictionary) contains the hostname (dictionary)
- Hostname is the value of the *hostname* variable that corresponds to the name of the OS device
- Role is abstracted using the *ansible_network_os* variable that can take dellos6, dellos9, and dellos10 values
- Any role variable with a corresponding state variable setting to absent negates the configuration of that variable
- Setting an empty value to any variable negates the corresponding configuration
- *dellos_lag* (dictionary) holds a dictionary with the port-channel ID key in `Po <ID>` format (1 to 4096 for dellos9; 1 to 128 for dellos10 and dellos6)
- Variables and values are case-sensitive

**port-channel ID keys**

| Key        | Type                      | Description                                             | Support               |
|------------|---------------------------|---------------------------------------------------------|-----------------------|
| ``type``      | string: static,dynamic      | Configures the interface either as a static or dynamic LAG           | dellos6, dellos9, dellos10 |
| ``min_links`` | integer                       | Configures the minimum number of links in the LAG that must be in *operup* status (1 to 64 for dellos9; 1 to 32 dellos10; 1 to 8  dellos6) | dellos6, dellos9, dellos10 |
| ``hash`` | integer | Configures the hash value for dellos6 devices (1 to 7) | dellos6 |
| ``max_bundle_size`` | integer | Configures the maximum bundle size for the port channel  | dellos10 |
| ``lacp``     | dictionary | Specifies LACP fast-switchover or long timeout options | dellos9 |
| ``lacp.fast_switchover`` | boolean | Configures the fast-switchover option if set to true | dellos9 |
| ``lacp.long_timeout`` | boolean | Configures the long-timeout option if set to true | dellos9 |
| ``lacp_system_priority`` | integer | Configures the LACP system-priority value (1 to 65535 for dellos9) | dellos9, dellos10 |
| ``lacp_ungroup_vlt`` | boolean | Configures all VLT LACP members to be switchports if set to true | dellos9 |
| ``lacp_ungroup`` | list | Specifies the list of port-channels to become switchports (see ``lacp_ungroup.*``) | dellos9 |
| ``lacp_ungroup.port_channel`` | integer (required) | Specifies valid port-channel numbers |  dellos9 |
| ``lacp_ungroup.state`` | string: present,absent\* | Deletes the ungroup association if set to absent | dellos9 |
| ``channel_members``  | list  | Specifies the list of port members to be associated to the port-channel (see ``channel_members.*``) | dellos6, dellos9, dellos10 |
| ``channel_members.port`` | string  | Specifies valid dellos6, dellos9, and dellos10 interface names to be configured as port-channel members | dellos6, dellos9, dellos10 |
| ``channel_members.state`` | string: absent,present | Deletes the port member association if set to absent | dellos6, dellos9 |
| ``channel_members.mode`` | string: active,passive,on | Configures mode of channel members on dellos10 devices | dellos10 |
| ``channel_members.port_priority`` | integer | Configures port priority on dellos10 devices for channel members | dellos10 |
| ``channel_members.lacp_rate_fast`` | boolean | Configures the LACP rate as fast if set to true | dellos10 |
| ``state``  | string: absent,present\*           | Deletes the LAG corresponding to the port-channel ID if set to absent | dellos6, dellos9, dellos10 |

> **NOTE**: Asterisk (\*) denotes the default value if none is specified.

Connection variables
--------------------

Ansible Dell EMC Networking roles require connection information to establish communication with the nodes in your inventory. This information can exist in the Ansible *group_vars* or *host_vars* directories or inventory, or in the playbook itself.

| Key         | Required | Choices    | Description                                         |
|-------------|----------|------------|-----------------------------------------------------|
| ``ansible_host`` | yes      |            | Specifies the hostname or address for connecting to the remote device over the specified transport |
| ``ansible_port`` | no       |            | Specifies the port used to build the connection to the remote device; if value is unspecified, the ANSIBLE_REMOTE_PORT option is used; it defaults to 22 |
| ``ansible_ssh_user`` | no       |            | Specifies the username that authenticates the CLI login for the connection to the remote device; if value is unspecified, the ANSIBLE_REMOTE_USER environment variable value is used  |
| ``ansible_ssh_pass`` | no       |            | Specifies the password that authenticates the connection to the remote device  |
| ``ansible_become`` | no       | yes, no\*   | Instructs the module to enter privileged mode on the remote device before sending any commands; if value is unspecified, the ANSIBLE_BECOME environment variable value is used, and the device attempts to execute all commands in non-privileged mode |
| ``ansible_become_method`` | no       | enable, sudo\*   | Instructs the module to allow the become method to be specified for handling privilege escalation; if value is unspecified, the ANSIBLE_BECOME_METHOD environment variable value is used |
| ``ansible_become_pass`` | no       |            | Specifies the password to use if required to enter privileged mode on the remote device; if ``ansible_become`` is set to no this key is not applicable |
| ``ansible_network_os`` | yes      | dellos6/dellos9/dellos10, null\*  | Loads the correct terminal and cliconf plugins to communicate with the remote device |

> **NOTE**: Asterisk (\*) denotes the default value if none is specified.

Dependencies
------------

The *dellos-lag* role is built on modules included in the core Ansible code. These modules were added in Ansible version 2.2.0.

Example playbook
----------------

This example uses the *dellos-lag* role to setup port channel ID and description, and configures hash algorithm and minimum links for the LAG. Channel members can be configured for the port-channel either in static or dynamic mode. You can also delete the LAG with the port-channel ID or delete the members associated to it. This example creates a *hosts* file with the switch details and corresponding variables. The hosts file should define the *ansible_network_os* variable with corresponding Dell EMC networking OS name.

When *dellos_cfg_generate* is set to true, the variable generates the configuration commands as a .part file in *build_dir* path. By default, the variable is set to false. It writes a simple playbook that only references the *dellos-lag* role.

**Sample hosts file**

    leaf1 ansible_host= <ip_address> 

**Sample host_vars/leaf1**

    hostname: leaf1
    ansible_become: yes
    ansible_become_method: xxxxx
    ansible_become_pass: xxxxx
    ansible_ssh_user: xxxxx
    ansible_ssh_pass: xxxxx
    ansible_network_os: dellos9
    build_dir: ../temp/dellos9

    dellos_lag:
        Po 127:
          type: static
          min_links: 3
          lacp:
            long_timeout: true
            fast_switchover: true
          lacp_system_priority: 1
          lacp_ungroup_vlt: true
          lacp_ungroup:
            - port-channel:1
              state: present
          channel_members:
            - port: fortyGigE 1/4
              state: present
            - port: fortyGigE 1/5
              state: present
          state: present

**Simple playbook to setup system - leaf.yaml**

    - hosts: leaf1
      roles:
         - Dell-Networking.dellos-lag

**Run**

    ansible-playbook -i hosts leaf.yaml

(c) 2017 Dell Inc. or its subsidiaries. All Rights Reserved.
