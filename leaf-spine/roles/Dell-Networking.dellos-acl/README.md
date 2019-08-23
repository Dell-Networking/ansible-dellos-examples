ACL role
========

This role facilitates the configuration of an access-control list (ACL). It supports the configuration of different types of ACLs (standard and extended) for both IPv4 and IPv6, and assigns the access-class to the line terminals. This role is abstracted for dellos9 and dellos10.

The ACL role requires an SSH connection for connectivity to a Dell EMC Networking device. You can use any of the built-in OS connection variables.

Installation
------------

    ansible-galaxy install Dell-Networking.dellos-acl

Role variables
--------------

- Role is abstracted using the *ansible_network_os* variable that can take dellos9 or dellos10 values
- If *dellos_cfg_generate* is set to true, the variable generates the role configuration commands in a file
- Any role variable with a corresponding state variable set to absent negates the configuration of that variable
- Setting an empty value for any variable negates the corresponding configuration
- Variables and values are case-sensitive

**dellos_acl keys**

| Key        | Type                      | Description                                             | Support               |
|------------|---------------------------|---------------------------------------------------------|-----------------------|
| ``type`` | string (required): ipv4, ipv6, mac        | Configures the L3 (IPv4/IPv6) or L2 (MAC) access-control list | dellos9, dellos10 |
| ``name`` | string (required)           | Configures the name of the access-control list | dellos9, dellos10 |
| ``description`` | string           | Configures the description about the access-control list | dellos9, dellos10 |
| ``remark`` | list           | Configures the ACL remark (see ``remark.*``)  | dellos9, dellos10 |
| ``remark.number`` | integer (required)        | Configures the remark sequence number | dellos9, dellos10 |
| ``remark.description`` | string        | Configures the remark description | dellos9, dellos10 |
| ``remark.state`` | string: absent,present\*   | Deletes the configured remark for an ACL entry if set to absent | dellos9, dellos10 |
| ``extended`` | boolean: true,false         | Configures an extended ACL type if set to true; configures a standard ACL if set to false | dellos9 |
| ``entries`` | list | Configures ACL rules (see ``seqlist.*``) |  dellos9, dellos10 |
| ``entries.number`` | integer (required)       | Specifies the sequence number of the ACL rule | dellos9, dellos10 |
| ``entries.permit`` | boolean (required): true,false         | Specifies the rule to permit packets if set to true; specifies to reject packets if set to false | dellos9, dellos10 |
| ``entries.protocol`` | string (required)       | Specifies the type of protocol or the protocol number to filter | dellos9, dellos10 |
| ``entries.source`` | string (required)        | Specifies the source address to match in the packets | dellos9, dellos10 |
| ``entries.src_condition`` | string         | Specifies the condition to filter packets from the source address; ignored if MAC | dellos9, dellos10 |
| ``entries.destination`` | string (required)      | Specifies the destination address to match in the packets | dellos9, dellos10 |
| ``entries.dest_condition`` | string         | Specifies the condition to filter packets to the destination address | dellos9, dellos10 |
| ``entries.other_options`` | string         | Specifies the other options applied on packets (count, log, order, monitor, and so on) | dellos9, dellos10 |
| ``entries.state`` | string: absent,present\*   | Deletes the rule from the ACL if set to absent | dellos9, dellos10 |
| ``stage_ingress`` | list           | Configures ingress ACL to the interface (see ``stage_ingress.*``) | dellos9, dellos10 |
| ``stage_ingress.name`` | string (required)        | Configures the ingress ACL filter to the interface with this interface name | dellos9, dellos10 |
| ``stage_ingress.state`` | string: absent,present\*   | Deletes the configured ACL from the interface if set to absent | dellos9, dellos10 |
| ``stage_egress`` | list           | Configures egress ACL to the interface (see ``stage_egress.*``) | dellos9, dellos10 |
| ``stage_egress.name`` | string (required)        | Configures the egress ACL filter to the interface with this interface name | dellos9, dellos10 |
| ``stage_egress.state`` | string: absent,present\*   | Deletes the configured egress ACL from the interface if set to absent | dellos9, dellos10 |
| ``lineterminal`` | list | Configures the terminal to apply the ACL (see ``lineterminal.*``) | dellos9, dellos10 |
| ``lineterminal.line`` | string (required)      | Configures access-class on the line terminal | dellos9 |
| ``lineterminal.state`` | string: absent,present\*       | Deletes the access-class from line terminal if set to absent | dellos9, dellos10 |
| ``state`` | string: absent,present\*       | Deletes the ACL if set to absent | dellos9, dellos10 |

> **NOTE**: Asterisk (\*) denotes the default value if none is specified. 

Connection variables
--------------------

Ansible Dell EMC Networking roles require connection information to establish communication with the nodes in inventory. This information can exist in the Ansible *group_vars* or *host_vars* directories or inventory, or in the playbook itself.

| Key         | Required | Choices    | Description                                           |
|-------------|----------|------------|-------------------------------------------------------|
| ``ansible_host`` | yes      |            | Specifies the hostname or address for connecting to the remote device over the specified transport |
| ``ansible_port`` | no       |            | Specifies the port used to build the connection to the remote device; if value is unspecified, the ANSIBLE_REMOTE_PORT option is used; it defaults to 22 |
| ``ansible_ssh_user`` | no       |            | Specifies the username that authenticates the CLI login for the connection to the remote device; if value is unspecified, the ANSIBLE_REMOTE_USER environment variable value is used  |
| ``ansible_ssh_pass`` | no       |            | Specifies the password that authenticates the connection to the remote device |
| ``ansible_become`` | no       | yes, no\*   | Instructs the module to enter privileged mode on the remote device before sending any commands; if value is unspecified, the ANSIBLE_BECOME environment variable value is used, and the device attempts to execute all commands in non-privileged mode |
| ``ansible_become_method`` | no       | enable, sudo\*   | Instructs the module to allow the become method to be specified for handling privilege escalation; if value is unspecified, the ANSIBLE_BECOME_METHOD environment variable value is used |
| ``ansible_become_pass`` | no       |            | Specifies the password to use if required to enter privileged mode on the remote device; if ``ansible_become`` is set to no this key is not applicable |
| ``ansible_network_os`` | yes      | dellos6/dellos9/dellos10, null\*  | Loads the correct terminal and cliconf plugins to communicate with the remote device |

> **NOTE**: Asterisk (_*_) denotes the default value if none is specified.

Dependencies
------------

The *dellos-acl* role is built on modules included in the core Ansible code. These modules were added in Ansible version 2.2.0.

Example playbook
----------------

This example uses the *dellos-acl* role to configure different types of ACLs (standard and extended) for both IPv4 and IPv6 and assigns the access-class to the line terminals. The example creates a *hosts* file with the switch details and corresponding variables. The hosts file should define the *ansible_network_os* variable with the corresponding Dell EMC networking OS name. 

When *dellos_cfg_generate* is set to true, it generates the configuration commands as a .part file in the *build_dir* path. By default it is set to false. It writes a simple playbook that only references the *dellos-acl* role. 

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
    dellos_acl:
      - type: ipv4
        name: ssh-only
        description: ipv4acl
        extended: true
        remark:
          - number: 5
            description: "ipv4remark"
        entries:
          - number: 5
            permit: true
            protocol: tcp
            source: any
            src_condition: ack
            destination: any
            dest_condition: eq 22
            other_options: count
            state: present
        stage_ingress:
          - name: fortyGigE 1/28
            state: present
        stage_egress:
          - name: fortyGigE 1/28
            state: present
        lineterminal:
          - line: vty 1
            state: present
          - line: vty 2
            state: absent
        state: present
            
**Simple playbook to setup system - leaf.yaml**

    - hosts: leaf1
      roles:
         - Dell-Networking.dellos-acl

**Run**

    ansible-playbook -i hosts leaf.yaml

(c) 2017 Dell Inc. or its subsidiaries. All Rights Reserved.
