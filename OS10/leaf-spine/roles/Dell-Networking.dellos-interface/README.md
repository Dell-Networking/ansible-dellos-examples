Interface role
==============

This role facilitates the configuration of interface attributes. It supports the configuration of admin state, description, MTU, IP address, IP helper, suppress_ra and port mode. This role is abstracted for dellos9, dellos6, and dellos10.

The interface role requires an SSH connection for connectivity to a Dell EMC Networking device. You can use any of the built-in OS connection variables .

Installation
------------

    ansible-galaxy install Dell-Networking.dellos-interface

Role variables
--------------

- Role is abstracted using the *ansible_network_os* variable that can take dellos9, dellos6, and dellos10 values
- If *dellos_cfg_generate* is set to true, the variable generates the role configuration commands in a file
- Any role variable with a corresponding state variable setting to absent negates the configuration of that variable
- Setting an empty value for any variable negates the corresponding configuration
- *dellos_interface* (dictionary) holds a dictionary with the interface name; interface name can correspond to any of the valid OS interfaces with the unique interface identifier name
- For physical interfaces, the interface name must be in *<interfacename> <tuple>* format; for logical interfaces, the interface must be in *<logical_interfacename> <id>* format; physical interface name can be *fortyGigE 1/1* for dellos9 devices, *ethernet 1/1/32* for dellos10 devices, and *Te1/0/1* for dellos6 devices
- For interface ranges, the interface name must be in *range <interface_type> <node/slot/port[:subport]-node/slot/port[:subport]>* format; *range ethernet 1/1/1-1/1/4* for dellos10 devices
- Logical interface names can be *vlan 1* or *port-channel 1* for dellos9 devices, dellos6 devices, and dellos10 devices
- Variables and values are case-sensitive

> **NOTE**: Only define supported variables for the interface type. For example, do not define the *switchport* variable for a logical interface; do not configure portmode when *switchport* is present in dellos9 devices; do not define an IP address for physical interfaces in dellos6 devices.

**interface name keys**

| Key        | Type                      | Description                                             | Support               |
|------------|---------------------------|---------------------------------------------------------|-----------------------|
| ``desc``  | string         | Configures a single line interface description  | dellos6, dellos9, dellos10 |
| ``portmode`` | string | Configures port-mode according to the device type | dellos6 (access and trunk), dellos9 (hybrid), dellos10  |
| ``switchport`` | boolean: true,false\*  | Configures an interface in L2 mode |  dellos9, dellos10 |
| ``admin``      | string: up,down\*              | Configures the administrative state for the interface; configuring the value as administratively "up" enables the interface; configuring the value as administratively "down" disables the interface | dellos6, dellos9, dellos10 |
| ``mtu``        | integer                       | Configures the MTU size for L2 and L3 interfaces; example, MTU range is 594 to 12000 for dellos9 devices, 1280 to 65535 on dellos10 devices, and set globally on dellos6 devices | dellos9, dellos10 |
| ``fanout``     | string:dual, single, quad (dellos9); string:10g-4x, 40g-1x, 25g-4x, 100g-1x, 50g-2x (dellos10)   | Configures fanout to the appropriate value in dellos* devices.| dellos9, dellos10 |
| ``fanout_speed`` | string: 10G, 25G, 40G, 50G | Configures speed for the fanout port based on the fanout mode specified | dellos9 |
| ``fanout_state`` | string: present, absent* | Configures the fanout mode to a port if state is set to present | dellos9 |
| ``keepalive``     | boolean: true,false           | Configures keepalive on the port if set to true | dellos9 |  
| ``speed``     | string:10,100,1000,auto           | Configures interface speed parameters | dellos9               | 
| ``duplex``     | string: full,half           | Configures interface duplex parameters | dellos9                |
| ``auto_neg``     | boolean: true,false           | Configures auto-negotiation mode if set to true | dellos9            | 
| ``cr4_auto_neg``     | boolean: true,false           | Configures auto-negotiation mode on a CR4 interface type if set to true | dellos9         |
| ``suppress_ra`` | string; present,absent     | Configures IPv6 router advertisements if set to present | dellos6, dellos9, dellos10 |
| ``ip_type_dynamic`` | boolean: true,false           | Configures IP address DHCP if set to true (*ip_and_mask* is ignored if set to true) | dellos6, dellos9, dellos10 |
| ``ipv6_type_dynamic`` | boolean: true,false           | Configures an IPv6 address for DHCP if set to true (*ipv6_and_mask* is ignored if set to true) | dellos10 |
| ``ipv6_autoconfig`` | boolean: true,false           | Configures stateless configuration of IPv6 addresses if set to true (*ipv6_and_mask* is ignored if set to true) | dellos10 |
| ``class_vendor_identifier`` | string: present,absent,string | Configures the vendor-class identifier without a user-defined string if set to present; configures a vendor-class identifier with a user-defined string when a string is specified; ignored when *ip_type_dynamic* is set to false | dellos9  |
| ``option82`` | boolean: true,false\* | Configures option82 with the remote-id MAC address if *remote_id* is undefined; ignored when *ip_type_dynamic* is set to false | dellos9 |
| ``remote_id`` |string: hostname,mac,string | Configures option82 with the specified *remote-id*; ignored when *option82* is set to false | dellos9  |
| ``ip_and_mask`` | string | Configures the specified IP address to the interface on dellos9 and dellos10 devices; configures the specified IP address to the interface VLAN on dellos6 devices (192.168.11.1/24 format) | dellos6, dellos9, dellos10 |
| ``ip_and_mask_secondary`` | string | Configures the specified IP address as secondary address to the interface on dellos9 and dellos10 devices (192.168.11.2/24 format) | dellos9 |
| ``secondary_ip_state`` | string: absent,present\* | Deletes the secondary IP address if set to absent | dellos9    |
| ``ipv6_and_mask`` | string | Configures a specified IPv6 address to the interface on dellos9 and dellos10 devices; configures a specified IP address to the interface VLAN on dellos6 devices (2001:4898:5808:ffa2::1/126 format) | dellos6, dellos9, dellos10 |
| ``state_ipv6`` | string: absent,present\* | Deletes the IPV6 address if set to absent           | dellos10 | 
| ``ipv6_reachabletime``       | integer                       | Configures the reachability time for IPv6 neighbor discovery (0 to 3600000) | dellos6, dellos9 |
| ``ip_helper`` | list | Configures DHCP server address objects (see ``ip_helper.*``) | dellos6, dellos9, dellos10 |
| ``ip_helper.ip`` | string (required)         | Configures the IPv4 address of the DHCP server (A.B.C.D format)  | dellos6, dellos9, dellos10 |
| ``ip_helper.state`` | string: absent,present\* | Deletes the IP helper address if set to absent           | dellos6, dellos9, dellos10 |

> **NOTE**: Asterisk (*) denotes the default value if none is specified.

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

> **NOTE**: Asterisk (*) denotes the default value if none is specified.

Dependencies
------------

The *dellos-interface* role is built on modules included in the core Ansible code. These modules were added in Ansible version 2.2.0.

Example playbook
----------------

This example uses the *dellos-interface* role to set up description, MTU, admin status, portmode, and switchport details for an interface. The example creates a *hosts* file with the switch details and orresponding variables. The hosts file should define the  *ansible_network_os* variable with corresponding Dell EMC networking OS name.

When *dellos_cfg_generate* is set to true, the variable generates the configuration commands as a .part file in *build_dir* path. By default, this variable is set to false. The example writes a simple playbook that only references the *dellos-interface* role.

**Sample hosts file**

    leaf3 ansible_host= <ip_address>
 
**Sample host_vars/leaf3**

    hostname: "leaf3"
    ansible_become: yes
    ansible_become_method: xxxxx
    ansible_become_pass: xxxxx
    ansible_ssh_user: xxxxx
    ansible_ssh_pass: xxxxx
    ansible_network_os: dellos9
    build_dir: ../temp/dellos9

    dellos_interface:
        TenGigabitEthernet 1/8:
          desc: "Connected to Spine1"
          portmode:
          switchport: False
          mtu: 2500
          admin: up
          auto_neg: true
          speed: auto
          duplex: full
          keepalive: true
          ipv6_and_mask: 2001:4898:5808:ffa2::5/126
          suppress_ra : present
          ip_type_dynamic: true
          ip_and_mask: 192.168.23.22/24
          class_vendor_identifier: present
          option82: true
          remote_id: hostname
        fortyGigE 1/9:
          desc: "Connected to Spine2"
          switchport: False
          mtu: 2500
          admin: up
          cr4_auto_neg: true
          ip_and_mask: 192.168.234.20/31
          ip_and_mask_secondary: "192.168.234.21/31"
          secondary_ip_state: present
          suppress_ra: absent
          ip_type_dynamic: false
          class_vendor_identifier: absent
          option82: true
          remote_id: hostname
          ipv6_and_mask: 2001:4898:5808:ffa2::9/126
         Vlan 100:
           mtu: 4096
           admin: down
           ip_and_mask:
           ipv6_and_mask: 2002:4898:5408:faaf::1/64
           suppress_ra: present
           state_ipv6: absent
           ip_helper:
              - ip: 10.0.0.36
                state: absent
            ipv6_reachabletime: 600000

**Simple playbook to setup system - leaf.yaml**

    - hosts: leaf3
      roles:
         - Dell-Networking.dellos-interface
 
**Run**

    ansible-playbook -i hosts leaf.yaml

(c) 2017 Dell Inc. or its subsidiaries. All Rights Reserved.
