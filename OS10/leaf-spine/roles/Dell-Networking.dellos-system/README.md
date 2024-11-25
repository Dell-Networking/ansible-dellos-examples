System role
===========

This role facilitates the configuration of global system attributes, and is abstracted for dellos6, dellos9, and dellos10. It specifically enables configuration of hostname and enable password for all three dellos. In addition, dellos9 supports the configuration of management route, hash alogrithm, clock, line terminal, banner, and reload type.

The dellos-system role requires an SSH connection for connectivity to a Dell EMC Networking device. You can use any of the built-in OS connection variables .

Installation
------------

    ansible-galaxy install Dell-Networking.dellos-system

Role variables
--------------

- Role is abstracted using the *ansible_network_os* variable that can take dellos9, dellos6, and dellos10 values
- If *dellos_cfg_generate* is set to true, the variable generates the role configuration commands in a file
- Any role variable with a corresponding state variable set to absent negates the configuration of that variable
- Setting an empty value for any variable negates the corresponding configuration
- Variables and values are case-sensitive

**dellos_system keys**

| Key        | Type                      | Description                                             | Support               |
|------------|---------------------------|---------------------------------------------------------|-----------------------|
| ``hostname`` | string | Configures a hostname to the device (no negate command) | dellos9, dellos6, dellos10 |
| ``unique_hostname`` | boolean: true,false\* | Configures a unique hostname in the switch | dellos9 |
| ``enable_password`` | string              | Configures the enable password | dellos6, dellos9 |
| ``mtu`` | integer | Configures the maximum transmission unit (MTU) for all interfaces | dellos6  |
| ``hardware_forwarding`` | string: scaled-l2,scaled-l3-routes,scaled-l3-hosts         | Configures hardware forwarding mode | dellos10 |
| ``management_rt`` | list | Configures the management route | dellos9 |
| ``management_rt.ip`` | string (required) | Configures the IP destination prefix for the management route (A.B.C.D format for IPv4, A:B:C:D::E format for IPv6) | dellos9 |
| ``management_rt.ipv4`` | boolean: true\*,false | Specifies if the management route is an IPv4 or IPv6 address; if false or undefined, the IP is set as IPv6 | dellos9 |
| ``management_rt.state`` | string: absent,present\* | Deletes the management route if set to absent | dellos9 |
| ``line_terminal`` | dictionary | Configures the terminal line (see ``line_terminal.*``) | dellos9 |
| ``line_terminal.<terminal>`` | dictionary | Configures the primary or virtual terminal line (console <line_number> or vty <line_number> values) | dellos9 |
| ``<terminal>.exec_timeout`` | string | Configures the EXEC timeout (<min> <sec> values) | dellos9 |
| ``<terminal>.exec_banner`` | boolean: true,false\* | Configures the EXEC banner | dellos9 |
| ``<terminal>.login_banner`` | boolean: true,false\* | Configures the login banner | dellos9 |
| ``<terminal>.motd_banner`` | boolean: true,false\* | Configures the MOTD banner | dellos9 |
| ``service_passwd_encryption`` | boolean: true,false | Configures system password encryption  | dellos9 |
| ``hash_algo`` | dictionary | Configures hash algorithm commands (see ``hash_algo.*``) | dellos9, dellos10 |
| ``hash_algo.algo`` | list         | Configures hashing algorithm (see ``algo.*``)   | dellos9, dellos10 |
| ``algo.name`` | string (required)       | Configures the name of the hashing algorithm | dellos9, dellos10 |
| ``algo.mode`` | string (required)       | Configures the hashing algorithm mode |  dellos9, dellos10 |
| ``algo.stack_unit`` | integer       | Configures the stack-unit for the hashing algorithm | dellos9 |
| ``algo.port_set`` | integer       | Configures the port-pipe set for the hashing algorithm | dellos9 |
| ``algo.state`` | string: absent,present\*     | Deletes the hashing algorithm if set to absent           | dellos9, dellos10 |
| ``hash_algo.seed`` | list         | Configures the hashing algorithm seed (see ``seed.*``) | dellos9  |
| ``seed.value`` | integer (required)       | Configures the hashing algorithm seed value | dellos9 |
| ``seed.stack_unit`` | integer       | Configures the stack-unit for the hashing algorithm seed | dellos9 | 
| ``seed.port_set`` | integer       | Configures the port-pipe set for the hashing algorithm seed | dellos9 |
| ``seed.state`` | string: absent,present\*     | Deletes the hashing algorithm seed if set to absent     | dellos9 |
| ``banner`` | dictionary | Configures global banner commands (see ``banner.*``) | dellos9 |
| ``banner.login`` | dictionary | Configures the login banner (see ``login.*``) | dellos9 |
| ``login.ack_enable`` | boolean: true,false       | Configures positive acknowledgement | dellos9 |
| ``login.ack_prompt`` | string       | Configures the positive acknowledgement prompt  | dellos9 |
| ``login.keyboard_interactive`` | boolean: true,false       | Configures the keyboard interactive prompt | dellos9 |
| ``login.banner_text`` | string       | Configures the banner text for the login banner; 'c <banner-text> c' format where 'c' is a delimiting character | dellos9 |
| ``banner.exec`` | string       | Configures the banner text for EXEC process creation banner; 'c <banner-text> c' where 'c' is a delimiting character for dellos9 | dellos9 |
| ``banner.motd`` | string       | Configures the banner text for the message of the day banner; 'c <banner-text> c' where 'c' is a delimiting character for dellos9 | dellos9 |
| ``load_balance`` | dictionary | Configures the global traffic load balance (see ``load_balance.*``) | dellos9, dellos10 |
| ``load_balance.ingress_port`` | boolean: true,false       | Specifies whether to use the source port ID for the hashing algorithm | dellos9, dellos10 |
| ``load_balance.tcp_udp`` | boolean: true, false       | Configures whether to use TCP/UDP ports in packets for hashing algorithm | dellos9 |
| ``load_balance.ip_selection`` | list    | Configures IPv4 key fields to use in hashing algorithm; mutually exclusive with *load_balance.tcp_udp*  for dellos9 devices (see ``ip_selection.*``) | dellos9, dellos10 |
| ``ip_selection.field`` | string | Configures IPv4 key fields to use in hashing algorithm | dellos9, dellos10 |
| ``ip_selection.state`` | string: absent,present\* | Deletes the IPv4 key fields if set to absent | dellos9, dellos10 |
| ``load_balance.ipv6_selection`` | list    | Configures IPv6 key fields to use in hashing algorithm; mutually exclusive with *load_balance.tcp_udp*  for dellos9 devices (see ``ipv6_selection.*``) | dellos9, dellos10 |
| ``ipv6_selection.field`` | string | Configures IPv6 key fields to use in hashing algorithm | dellos9, dellos10 |
| ``ipv6_selection.state`` | string: absent,present\* | Deletes the IPv6 key fields if set to absent | dellos9, dellos10 |
| ``load_balance.mac_selection`` | list    | Configures MAC key fields to use in hashing algorithm (see ``mac_selection.*``) | dellos10 |
| ``mac_selection.field`` | string | Configures MAC key fields to use in hashing algorithm | dellos10 |
| ``mac_selection.state`` | string: absent,present\* | Deletes the MAC key fields if set to absent | dellos10 |
| ``load_balance.tcp_udp_selection`` | list    | Configures TCP UDP ports for load balancing configurations (see ``tcp_udp_selection.*``) | dellos10 |
| ``tcp_udp_selection.field`` | string | Configures TCP UDP port fields to use in hashing algorithm | dellos10 |
| ``tcp_udp_selection.state`` | string: absent,present\* | Deletes the TCP UDP ports if set to absent | dellos10 |
| ``load_balance.tunnel`` | dictionary    | Configures tunnel key fields to use in hashing algorithm (see ``tunnel.*``) | dellos9 |
| ``tunnel.hash_field`` | list    | Configures hash field selection (see ``hash_field.*``) | dellos9 |
| ``hash_field.name`` | string (required)       | Configures the hash field selection | dellos9 |
| ``hash_field.header`` | string       | Configures header for load balance | dellos9 |
| ``hash_field.state`` | string: absent,present\*     | Deletes the hash key selection field if set to absent     | dellos9 |
| ``clock`` | dictionary | Configures time-of-day clock (see ``clock.*``) | dellos9 |
| ``clock.summer_time`` | dictionary    | Configures summer (daylight savings) time (see ``summer_time.*``)    | dellos9 |
| ``summer_time.timezone_name`` | string (required)       | Configures the time zone name | dellos9 |
| ``summer_time.type`` | string (required)       | Configures absolute or recurring summer time | dellos9 |
| ``summer_time.start_datetime`` | string       | Configures start datetime; <date> <month> <year> <hrs:mins> format | dellos9 |
| ``summer_time.end_datetime`` | string       | Configures end datetime; <date> <month> <year> <hrs:mins> format | dellos9 |
| ``summer_time.offset_mins`` | integer       | Configures offset minutes to add (1 to 1440) | dellos9 |
| ``summer_time.state`` | string: absent,present\*     | Deletes the summer time clock if set to absent     | dellos9 |
| ``clock.timezone`` | dictionary    | Configures timezone (see ``timezone.*``)     | dellos9 |
| ``timezone.name`` | string (required)       | Configures the timezone name | dellos9 |
| ``timezone.offset_hours`` | integer       | Configures offset hours to add (-23 to 23) | dellos9 |
| ``timezone.offset_mins`` | integer       | Configures offset minutes to add (0 to 59) | dellos9 |
| ``timezone.state`` | string: absent,present\*     | Deletes the time zone if set to absent   | dellos9 |
| ``reload_type`` | dictionary | Configures the reload type (see ``reload_type.*``) | dellos9 |
| ``reload_type.auto_save`` | boolean: true,false\*     | Configures the auto save option for downloaded configuration/script file    | dellos9 |
| ``reload_type.boot_type`` | string: bmp-reload,normal-reload    | Configures the boot type     | dellos9 |
| ``reload_type.boot_type_state`` | string: absent,present\*    | Deletes the boot type if set to absent    | dellos9 |
| ``reload_type.config_scr_download`` | boolean: true,false\*     | Configures whether config/script file needs to be downloaded     | dellos9 |
| ``reload_type.dhcp_timeout`` | integer    | Configures DHCP timeout in minutes (0 to 50)     | dellos9 |
| ``reload_type.retry_count`` | integer    | Configures the number of retries for image and configuration download (0 to 6)     | dellos9 |
| ``reload_type.relay`` | boolean: true,false\*     | Configures the addition of option82 in DHCP client packets     | dellos9 |
| ``reload_type.relay_remote_id`` | string    | Configures customize remote ID     | dellos9 |
| ``reload_type.vendor_class_identifier`` | boolean: true,false\*     | Configures vendor-class-identifier for DHCP option60 | dellos9 |

> **NOTE**: Asterisk (\*) denotes the default value if none is specified. 

Connection variables
********************

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

The *dellos-system* role is built on modules included in the core Ansible code. These modules were added in Ansible version 2.2.0.

Example playbook
----------------

This example uses the *dellos-system role* to completely set the NTP server, hostname, enable password, management route, hash alogrithm, clock, line terminal, banner and reload type. It creates a *hosts* file with the switch details and corresponding variables. The hosts file should define the *ansible_network_os* variable with corresponding Dell EMC networking OS name. 

When *dellos_cfg_generate* is set to true, the variable generates the configuration commands as a .part file in *build_dir* path. By default, the variable is set to false. The system role writes a simple playbook that only references the *dellos-system* role. By including the role, you automatically get access to all of the tasks to configure system features. 

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
	  
    dellos_system:
      hostname: host1
      unique_hostname: True
      enable_password: dell
      service_passwd_encryption: true
      banner:
        exec: t hai t
        login:
          ack_enable: true
          ack_prompt: testbanner
          keyboard_interactive: true
          banner_text: cloginbannerc
        motd: t ansibletest t
      hash_algo:
        algo:
          - name: lag
            mode: xor1
            stack_unit: 0
            port_set: 0
            state: present
          - name: ecmp
            mode: xor1
            stack_unit: 0
            port_set: 0
            state: present
        seed:
          - value: 3
            stack_unit: 0
            port_set: 0
            state: present
          - value: 2
            state: present
      load_balance:
        ingress_port: true
        ip_selection: 
           - field: vlan dest-ip
             state: present
        ipv6_selection: 
           - field: dest-ipv6 vlan
             state: present
        tunnel:
          hash_field:
            - name: mac-in-mac
              header: tunnel-header-mac
              state: present
      clock:
        summer_time:
          timezone_name: PST
          type: date
          start_datetime: 2 jan 1993 22:33
          end_datetime: 3 jan 2017 22:33
          offset_mins: 20
        timezone:
          name: IST
          offset_hours: -5
          offset_mins: 20
      reload_type:
        auto_save: true
        boot_type: normal-reload
        boot_type_state: absent
        config_scr_download: true
        dhcp_timeout: 5
        retry_count: 3
        relay: true
        relay_remote_id: ho
        vendor_class_identifier: aa
      management_rt:
        - ip: 10.16.148.254
          state: present
          ipv4: True
      line_terminal:
        vty 0:
          exec_timeout: 40
          exec_banner: true
        vty 1:
          exec_timeout: 40 200
          motd_banner: true
 
**Simple playbook to setup system - leaf.yaml**

    - hosts: leaf1
      roles:
         - Dell-Networking.dellos-system

**Run**

    ansible-playbook -i hosts leaf.yaml

(c) 2017 Dell Inc. or its subsidiaries. All Rights Reserved.
