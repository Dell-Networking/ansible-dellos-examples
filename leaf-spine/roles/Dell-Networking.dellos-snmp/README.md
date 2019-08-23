SNMP role
=========

This role facilitates the configuration of global SNMP attributes. It supports the configuration of SNMP server attributes including users, group, community, location, and traps. This role is abstracted for dellos9, dellos6 and dellos10.

The SNMP role requires an SSH connection for connectivity to a Dell EMC Networking device. You can use any of the built-in OS connection variables .

Installation
------------

    ansible-galaxy install Dell-Networking.dellos-snmp

Role variables
--------------

- Role is abstracted using the *ansible_network_os* variable that can take dellos9, dellos6, and dellos10 values
- If *dellos_cfg_generate* is set to true, the variable generates the role configuration commands in a file
- Any role variable with a corresponding state variable set to absent negates the configuration of that variable
- Setting an empty value for any variable negates the corresponding configuration
- Variables and values are case-sensitive

**dellos_snmp keys**

| Key        | Type                      | Description                                             | Support               |
|------------|---------------------------|---------------------------------------------------------|-----------------------|
| ``snmp_contact`` | string | Configures SNMP contact information  | dellos6, dellos9, dellos10 |
| ``snmp_server_vrf`` | boolean: true, false\* | Enables SNMP-server VRF globally | dellos9 |
| ``snmp_location`` | string | Configures SNMP location information | dellos6, dellos9, dellos10 |
| ``snmp_community`` | list | Configures SNMP community information (see ``snmp_community.*``) | dellos6, dellos9, dellos10 |
| ``snmp_community.name`` | string (required)         | Configures the SNMP community string | dellos6, dellos9, dellos10 |
| ``snmp_community.access_mode`` | string: ro,rw           | Configures access-mode for the community | dellos6, dellos9, dellos10 |
| ``snmp_community.state`` | string: absent,present\*   | Deletes the SNMP community information if set to absent | dellos6, dellos9, dellos10 |
| ``snmp_host`` | list | Configures SNMP hosts to receive SNMP traps (see ``snmp_host.*``) | dellos6, dellos9, dellos10 |
| ``snmp_host.ip`` | string | Configures the IP address of the SNMP trap host | dellos6, dellos10  |
| ``snmp_host.ipv4`` | string  | Configures the IPv4 address for the SNMP trap host | dellos9 |
| ``snmp_host.ipv6`` | stirng  | Configures the IPv6 address for the SNMP trap host | dellos9  |
| ``snmp_host.communitystring`` | string | Configures the SNMP community string of the trap host | dellos6, dellos9, dellos10 |
| ``snmp_host.udpport`` | string | Configures the UDP number of the SNMP trap host (0 to 65535) | dellos6, dellos9, dellos10 |
| ``snmp_host.version`` | string (required) | Specifies the SNMP version of the host (either 1 or 2c or 3 in dellos9, 1 or 2c in dellos10) | dellos9, dellos10 |
| ``snmp_host.vrf`` | list | Configures the SNMP VRF trap for the SNMP host (list of VRF names) | dellos9 |
| ``snmp_host.state`` | string: absent,present\* | Deletes the SNMP trap host if set to absent | dellos6, dellos9, dellos10 |
| ``snmp_traps`` | list | Configures SNMP traps (see ``snmp_traps.*``) | dellos6, dellos9, dellos10  |
| ``snmp_traps.name`` | string | Enables SNMP traps   | dellos6, dellos9, dellos10 |
| ``snmp_traps.state`` | string: absent,present\* | Deletes the SNMP trap if set to absent | dellos6, dellos9, dellos10 |
| ``snmp_engine_id`` | string | Configures the SNMPv3 engineID for the local agent | dellos9 |
| ``snmp_view`` | list | Configures SNMPv3 view information (see ``snmp_view.*``) | dellos9 |
| ``snmp_view.name`` | string | Configures the SNMP view name (20 characters maximum) | dellos9 |
| ``snmp_view.oid_subtree`` | integer | Configures the SNMP view for the OID subtree | dellos9 |
| ``snmp_view.include`` | boolean: true,false | Specifies whether the MIB family should be included or excluded from the view | dellos9 |
| ``snmp_user``      | list | Configures SNMP users for each group name (see ``snmp_user.*``) | dellos9 |
| ``snmp_user.name`` | string (required) | Configures the SNMP user name | dellos9 |
| ``snmp_user.group_name`` | string (required) | Configures the SNMP group name for the user | dellos9 |
| ``snmp_user.version`` | string: 1,2c,3 (required) | Configures a user entry with the specified SNMP version (either 1 or 2c or 3) | dellos9 |
| ``snmp_user.access_list`` | dictionary | Configures access-list details; required to configure or negate if defined | dellos9 |
| ``snmp_user.access_list.access`` | string | Configures the access-list associated with the user | dellos9 |
| ``snmp_user.access_list.ipv6`` | string | Configures the IPv6 access-list associated with the user | dellos9 |
| ``snmp_user.encryption`` | boolean: true,false\* | Specifies the encryption for the SNMP user if set to true | dellos9 |
| ``snmp_user.auth_algorithm`` | string: md5,sha | Configures the authorization algorithm for the SNMP user | dellos9 |
| ``snmp_user.auth_pass`` | string | Configures the authentication password for the user  | dellos9 |
| ``snmp_user.state`` | string: absent,present\* | Deletes the SNMP user if set to absent | dellos9 |
| ``snmp_group``      | list | Configures SNMP groups (see ``snmp_group.*``) | dellos9  |
| ``snmp_group.name`` | string (required) | Configures the SNMP group name | dellos9 |
| ``snmp_group.version`` | string (required) | Configures the group entry with the specified SNMP version (either 1 or 2c or 3) | dellos9 |
| ``snmp_group.access_list`` | dict | Configures access-list entries for the group; required to configure or negate if defined | dellos9 |
| ``snmp_group.access_list.access`` | string | Configures the access-list associated with the group | dellos9 |
| ``snmp_group.access_list.ipv6`` | string | Configures the IPv6 access-list associated with the group | dellos9 |
| ``snmp_group.view`` | dict | Configures view entries for the group; required to configure or negate if defined | dellos9 |
| ``snmp_group.view.notify`` | string | Configures notify view associated with the group | dellos9 |
| ``snmp_group.view.read`` | string | Configures read view associated with the group | dellos9 |
| ``snmp_group.view.write`` | string | Configures write view associated with the group | dellos9 |
| ``snmp_group.context`` | list | Configures context list entries (see ``snmp_group.context.*``) | dellos9 |
| ``snmp_group.context.context_name`` | string | Configures SNMP-group entries with specified context name | dellos9 |
| ``snmp_group.context.access_list`` | dictionary | Configures access-list entries for the group with context | dellos9 |
| ``snmp_group.context.access_list.access`` | string | Configures the access-list associated with the group | dellos9 |
| ``snmp_group.context.access_list.ipv6`` | string | Configures the IPv6 access-list associated with the group | dellos9 |
| ``snmp_group.context.view`` | dictionary | Configures view entries for the group with context  | dellos9 |
| ``snmp_group.context.view.notify`` | string | Configures notify view associated with the group | dellos9 |
| ``snmp_group.context.view.read`` | string | Configures read view associated with the group | dellos9 |
| ``snmp_group.context.view.write`` | string | Configures write view associated with the group | dellos9 |
| ``snmp_group.context.state`` | string: absent,present | Deletes the context entries with the group if set to absent | dellos9 |
| ``snmp_group.state`` | string: absent,present\* | Deletes the associated SNMP group if set to absent | dellos9 |

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

The *dellos-snmp* role is built on modules included in the core Ansible code. These modules were added in Ansible version 2.2.0.

Example playbook
----------------

This example uses the *dellos.dellos-snmp* role to completely set up the SNMP server attributes. It creates a *hosts* file with the switch details and corresponding variables. The hosts file should define the *ansible_network_os* variable with corresponding Dell EMC networking OS name. 

When *dellos_cfg_generate* is set to true, the variable generates the configuration commands as a .part file in *build_dir* path. By default, the variable is set to false. It writes a simple playbook that only references the *dellos-snmp* role. By including the role, you automatically get access to all of the tasks to configure SNMP features. 

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
	  
    dellos_snmp:
      snmp_contact:  test
      snmp_location: chennai
      snmp_server_vrf: test
      snmp_community:
        - name: public
          access_mode: ro
          state: present
        - name: private
          access_mode: rw
          state: present
      snmp_host:
        - ipv6: 2001:4898:f0:f09b::2000
          version: "3"
          security_level: auth
          communitystring:
          udpport:
          state: absent
      snmp_traps:
        - name: config
          state: present
      snmp_engine_id: 1234567890
      snmp_view:
        - name: view_1
          oid_subtree: 2
          include: false
          state: absent
      snmp_user:
        - name: user_1
          group_name: grp1
          version: 3
          access_list:
            access: a1
            ipv6: ip1
          encryption: true
          auth_algorithm: md5
          auth_pass: 12345678
          state: present
      snmp_group:
        - name: group_1
          version: 2c
          access_list:
            access: a1
            ipv6: ip1
          state: absent
        - name: group_2
          version: 3
          security_level: priv
          access_list:
            access: a1
            ipv6: ip1
          context:
            - context_name: c1
              state: present
            - context_name: c2
              access_list:
                access: a1
              view:
                read: r1
              state: present 
          state: present

**Simple playbook to setup snmp - leaf.yaml**

    - hosts: leaf1
      roles:
         - Dell-Networking.dellos-snmp

**Run**

    ansible-playbook -i hosts leaf.yaml

(c) 2017 Dell Inc. or its subsidiaries. All Rights Reserved.
