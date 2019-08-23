# xSTP role

This role facilitates the configuration of xSTP attributes. It supports multiple version of spanning-tree protocol (STP), rapid spanning-tree (RSTP), rapid per-VLAN spanning-tree (Rapid PVST+), multiple spanning-tree (MST), and per-VLAN spanning-tree (PVST). It supports the configuration of bridge priority, enabling and disabling spanning-tree, creating and deleting instances, and mapping virtual LAN (VLAN) to instances. This role is abstracted for OS6, OS9, and OS10.

The xSTP role requires an SSH connection for connectivity to a Dell EMC Networking device. You can use any of the built-in OS connection variables .

Installation
------------

    ansible-galaxy install Dell-Networking.dellos-xstp

Role variables
--------------

- *dellos_xstp*(dictionary) contains the hostname (dictionary)
- Hostname is the value of the *hostname* variable that corresponds to the name of the OS device
- Role is abstracted using the *ansible_network_os* variable that can take dellos6, dellos9, and dellos10 values
- Any role variable with a corresponding state variable set to absent negates the configuration of that variable
- Setting an empty value to any variable negates the corresponding configuration
- Variables and values are case-sensitive

**hostname keys**

| Key        | Type                      | Description                                             | Support              |
|------------|---------------------------|---------------------------------------------------------|----------------------|
| ``type``       | string (required) | Configures the type of spanning-tree mode specified that can vary according to the OS device; dellos9 devices include STP, RSTP, PVST, MSTP; dellos6 and dellos10 devices include RSTP, rapid-PVST, MST | dellos6, dellos9, dellos10 |
| ``enable``  | boolean: true,false             | Enables/disables the spanning-tree protocol specified in the type variable | dellos6, dellos9, dellos10 |
| ``mac_flush_timer`` | integer | Configures the mac_flush_timer value in dellos10 devices (0 to 500 range) | dellos10 |
| ``stp``  | dictionary             | Configures simple spanning-tree protocol (see ``stp.* keys``) | dellos6, dellos9 |
| ``stp.bridge_priority`` | integer | Configures bridge-priority for the spanning-tree (0 to 61440 range in multiples of 4096) | dellos6, dellos9 |
| ``stp.state`` | string: absent,present\* | Deletes the configured STP if set to absent | dellos9 |
| ``rstp``  | dictionary             | Configures rapid spanning-tree (see ``rstp.*``)  | dellos6, dellos9, dellos10 |
| ``rstp.bridge_priority`` | integer | Configures bridge-priority for the spanning-tree (0 to 61440 range in multiples of 4096) | dellos6, dellos9, dellos10 |
| ``rstp.max_age`` | integer  | Configures the max_age timer for RSTP (6 to 40 range in dellos10 devices) | dellos10 |
| ``rstp.hello_time`` | integer | Configures the hello-time for RSTP (1 to 10 range in dellos10 devices) | dellos10 |
| ``rstp.forward_time`` | integer | Configures the forward-time for RSTP (4 to 30 range in dellos10 devices) | dellos10 |
| ``rstp.force_version`` | strin: stp | Configures the force version for the BPDUs transmitted by RSTP in dellos10 devices | dellos10 |
| ``rstp.mac_flush_threshold`` | integer | Configures the MAC flush threshold for RSTP (1 to 65535 range in dellos10 devices) | dellos10 |
| ``rstp.state ``| string: absent,present\* | Deletes the configured RSTP in dellos9 devices if set to absent | dellos9 |
| ``pvst``  | dictionary     | Configures per-VLAN spanning-tree protocol (see ``pvst.*``) | dellos6, dellos9, dellos10 |
| ``pvst.vlan`` | list | Configures the VLAN for PVST (see ``vlan.*``)  | dellos6, dellos9, dellos10 |
| ``vlan.range_or_id``  | string             | Configures a VLAN/range of VLANs for the per-VLAN spanning-tree protocol | dellos6, dellos9, dellos10 |
| ``vlan.max_age`` | integer  | Configures the max_age timer for a VLAN (6 to 40 range in dellos10 devices) | dellos10 |
| ``vlan.hello_time`` | integer | Configures the hello-time for a VLAN (1 to 10 range in dellos10 devices) | dellos10 |
| ``vlan.forward_time`` | integer | Configures the forward-time for a VLAN (4 to 30 range in dellos10 devices) | dellos10 |
| ``vlan.enable`` | boolean: true,false | Enables or disables spanning-tree for the associated VLAN range_or_id in dellos10 devices | dellos10 |
| ``vlan.mac_flush_threshold`` | integer | Configures the MAC flush threshold for a VLAN (1 to 65535 range in dellos10 devices) | dellos10 |
| ``vlan.root`` | string: primary,secondary | Designates the primary or secondary root for the associated VLAN range_or_id in dellos10 devices; mutually exclusive with *vlan.bridge_priority* | dellos10 |
| ``vlan.bridge_priority`` | integer | Configures bridge-priority for the per-VLAN spanning-tree (0 to 61440 range in multiples of 4096); mutually exclusive with *vlan.root* | dellos6, dellos9, dellos10 |
| ``vlan.state`` | string: absent, present\* | Deletes the configured PVST vlan with id if set to absent | dellos6 |
| ``pvst.state`` | string: absent,present\* | Deletes the configured PVST if set to absent | dellos9 |
| ``mstp``  | dictionary     | Configures multiple spanning-tree protocol (see ``mstp.*``)  | dellos6, dellos9, dellos10 |
| ``mstp.max_age`` | integer  | Configures the max_age timer for MSTP (6 to 40 range in dellos10 devices) | dellos10 |
| ``mstp.max_hops`` | integer | Configures the max-hops for MSTP (6 to 40 range in dellos10 devices) | dellos10 |
| ``mstp.hello_time`` | integer | Configures the hello-time for MSTP (1 to 10 range in dellos10 devices) | dellos10 |
| ``mstp.forward_time`` | integer | Configures the forward-time for MSTP (4 to 30 range in dellos10 devices) | dellos10 |
| ``mstp.force_version`` | string: stp,rstp | Configures the force-version for the BPDUs transmitted by MSTP in dellos10 devices | dellos10 |
| ``mstp.mstp_instances`` | list | Configures a MSTP instance (see ``mstp_instances.*``)  | dellos6, dellos9, dellos10 |
| ``mstp_instances.number``     | integer                   | Configures the multiple spanning-tree instance number | dellos6, dellos9 |
| ``mstp_instances.number_or_range``     | integer                   | Configures the multiple spanning-tree instance number in dellos10 devices| dellos10 |
| ``mstp_instances.vlans``      | string     | Configures a VLAN/range of VLANs by mapping it to the instance number in dellos9 and dellos6 devices | dellos6, dellos9 |
| ``mstp_instances.bridge_priority`` | integer | Configures the bridge-priority for the spanning-tree (0 to 61440 range in multiples of 4096); mutually exclusive with *mstp_instances.root* | dellos6, dellos9, dellos10 |
| ``mstp_instances.enable`` | boolean: true,false | Enables or disables spanning-tree for the associated MSTP instance in dellos10 devices | dellos10 |
| ``mstp_instances.mac_flush_threshold`` | integer | Configures the MAC flush-threshold for an MSTP instance (1 to 65535 range in dellos10 devices | dellos10 |
| ``mstp_instances.root`` | string: primary,secondary | Designates the primary or secondary root for the associated MSTP instance in dellos10 devices; mutually exclusive with *mstp_instances.bridge_priority* | dellos10 |
| ``mstp_instances.vlans_state`` | string: absent,present\* | Deletes a set of VLANs mapped to the spanning-tree instance if set to absent | dellos6, dellos9 |
| ``mstp.state`` | string: absent,present\* | Deletes the configured MSTP if set to absent | dellos9 |
| ``mstp.mst_config`` | dictionary | Configures multiple spanning-tree (see ``mstp.mst_config.*``); supported in dellos10 devices | dellos10 |
| ``mst_config.name`` | string | Configures the name which is specified for the MSTP | dellos10 |
| ``mst_config.revision`` | integer | Configures the revision number for MSTP | dellos10 |
| ``mst_config.cfg_list`` | list | Configures the multiple spanning-tree list (see ``mst_config.cfg_list.*``) | dellos10 |
| ``cfg_list.number`` | integer | Specifies the MSTP instance number | dellos10 |
| ``cfg_list.vlans``      | string     | Configures a VLAN/range of VLANs by mapping it to an instance number in dellos10 devices | dellos10 |
| ``cfg_list.vlans_state`` | string: absent,present\* | Deletes a set of VLANs mapped to the spanning-tree instance if set to absent | dellos10 |
| ``intf`` | list | Configures multiple spanning-tree in an interface (see ``intf.*``)  | dellos6, dellos9, dellos10 |
| ``intf <interface name>``| dictionary | Configures the interface name (see ``intf.<interface name>.*``) | dellos6, dellos9, dellos10 |
| ``intf.<interface name>.stp_type`` | list: stp,mstp,MSTi,pvst,rstp | Configures the list of spanning-tree in an interface | dellos9 |
| ``intf.<interface name>.edge_port`` | boolean: true,false | Configures the EdgePort as dynamic if set to true in dellos10 devices; in dellos9 devices according to the stp_type EdgePort is configured; in OS6 devices it enables port fast at the interface level if set to true | dellos6, dellos9, dellos10 |
| ``intf.<interface name>.bpdu_filter``| boolean: true,false | Enables or disables bpdufilter at the interface | dellos10 |
| ``intf.<interface name>.bpdu_guard``| boolean: true,false | Enables or disables bpduguard at the interface | dellos10 |
| ``intf.<interface name>.guard``| string: loop,root,none | Configures guard on the interface | dellos10 |
| ``intf.<interface name>.enable`` | boolean: true,false | Enables or disables spanning-tree at the interface level  | dellos10 |
| ``intf.<interface name>.link_type``| string: auto,point-to-point,shared. | Configures the link type at the interface | dellos10 |
| ``intf.<interface name>.rstp`` | dictionary | Configures the RSTP interface name (see ``intf.<interface name>.rstp.*``) | dellos10 |
| ``rstp.priority``| integer | Configures the RSTP priority value at the interface | dellos10 |
| ``rstp.cost`` | integer | Configures the RSTP cost value at the interface | dellos10 |
| ``intf.<interface name>.msti`` | list | Configures the MSTi interface name (see ``intf.<interface name>.msti``) | dellos10 |
| ``msti.instance_number`` | integer or range | Specifies the MSTP instance number or range | dellos10 |
| ``msti.priority`` | integer | Specifies the priority value to be configured at the interface | dellos10 |
| ``msti.cost`` | integer | Specifies the cost value to be configured at the interface | dellos10 |
| ``intf.<interface name>.vlan`` | list | Configures the VLAN interface name (see ``intf.<interface name>.vlan``)  | dellos10 |
| ``vlan.instance_number`` | integer or range | Specifies the VLAN ID or range | dellos10 |
| ``vlan.priority`` | integer | Specifies the priority value to be configured at the interface | dellos10 |
| ``vlan.cost`` | integer | Specifies the cost value to be configured at the interface | dellos10 |

> **NOTE**: Asterisk (_*_) denotes the default value if none is specified.

Connection variables
--------------------

Ansible Dell EMC Networking roles require connection information to establish communication with the nodes in your inventory. This information can exist in the Ansible *group_vars* or *host_vars* directories or inventory or in the playbook itself.

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

> **NOTE**: Asterisk (\*) denotes the default value if none is specified.

Dependencies
------------

The *dellos-xstp* role is built on modules included in the core Ansible code. These modules were added in Ansible version 2.2.0.

Example playbook
----------------

This example uses the *dellos.dellos-xstp* role to configure different variants of spanning-tree. Based on the type of STP and defined objects, VLANs are associated and bridge priorities are assigned. It creates a *hosts* file with the switch details, and a *host_vars* file with connection variables. The corresponding role variables are defined in the *vars/main.yml* file at the role path. 
It writes a simple playbook that only references the *dellos-xstp* role. By including the role, you automatically get access to all of the tasks to configure xSTP. 

**Sample hosts file**

    spine1 ansible_host= <ip_address>

**Sample host_vars/spine1**
    
    hostname: spine1
    ansible_become: yes
    ansible_become_method: xxxxx
    ansible_become_pass: xxxxx
    ansible_ssh_user: xxxxx
    ansible_ssh_pass: xxxxx
    ansible_network_os: dellos9
    build_dir: ../temp/dellos9

**Sample vars/main.yml**

     dellos_xstp:
        type: rstp
        enable: true
        stp:
          bridge_priority: 4096
          state: present
        rstp:
          bridge_priority: 4096
        pvst:
          vlan:
            - range_or_id: 10
              bridge_priority: 4096
        mstp:
          mstp_instances:
            - number: 1
              vlans: 10,12
              bridge_priority: 4096
              vlans_state: present
        intf:
          fortyGigE 1/25
            stp_type:
              - stp
              - mstp
            edge_port: true

**Simple playbook to setup system - spine.yml**

    - hosts: spine
      roles:
         - Dell-Networking.dellos-xstp
 
**Run**

    ansible-playbook -i hosts spine.yml

(c) 2017 Dell Inc. or its subsidiaries. All Rights Reserved.
