# Explore using ansible for writing Dell switch configs.

This is meant to get started with just writing the config files and
not updating a running switch.  This is a helpful first step to working
with the modules and understanding how the configurations
are created from input data.

We follow the examle of the CLOS fabric datacenter configuration.
https://ansible-dellos-docs.readthedocs.io/en/latest/clos_fabric_example.html

See the docs here https://ansible-dellos-docs.readthedocs.io/en/latest/

Clone this examples repo and cd to the cloned directory.

Set up the python env:
```
python3 -m venv venv
. venv/bin/activate
pip install wheel
pip install ansible
```

Change to clos-fabric example:
```
cd clos-fabric
```

Create the list of Dell switch mgmt roles.  We are preferring clones
from the git repo rather and a static install.
```
cat > dellemc_roles.yml << EOF
- src: https://github.com/Dell-Networking/ansible-role-dellos-aaa
  name: dellos-aaa
- src: https://github.com/Dell-Networking/ansible-role-dellos-acl
  name: dellos-acl
- src: https://github.com/Dell-Networking/ansible-role-dellos-bgp
  name: dellos-bgp
- src: https://github.com/Dell-Networking/ansible-role-dellos-copy-config
  name: dellos-copy-config
- src: https://github.com/Dell-Networking/ansible-role-dellos-dcb
  name: dellos-dcb
- src: https://github.com/Dell-Networking/ansible-role-dellos-dns
  name: dellos-dns
- src: https://github.com/Dell-Networking/ansible-role-dellos-ecmp
  name: dellos-ecmp
- src: https://github.com/Dell-Networking/ansible-role-dellos-flow-monitor
  name: dellos-flow-monitor
- src: https://github.com/Dell-Networking/ansible-role-dellos-image-upgrade
  name: dellos-image-upgrade
- src: https://github.com/Dell-Networking/ansible-role-dellos-interface
  name: dellos-interface
- src: https://github.com/Dell-Networking/ansible-role-dellos-lag
  name: dellos-lag
- src: https://github.com/Dell-Networking/ansible-role-dellos-lldp
  name: dellos-lldp
- src: https://github.com/Dell-Networking/ansible-role-dellos-logging
  name: dellos-logging
- src: https://github.com/Dell-Networking/ansible-role-dellos-ntp
  name: dellos-ntp
- src: https://github.com/Dell-Networking/ansible-role-dellos-prefix-list
  name: dellos-prefix-list
- src: https://github.com/Dell-Networking/ansible-role-dellos-qos
  name: dellos-qos
- src: https://github.com/Dell-Networking/ansible-role-dellos-route-map
  name: dellos-route-map
- src: https://github.com/Dell-Networking/ansible-role-dellos-sflow
  name: dellos-sflow
- src: https://github.com/Dell-Networking/ansible-role-dellos-snmp
  name: dellos-snmp
- src: https://github.com/Dell-Networking/ansible-role-dellos-system
  name: dellos-system
- src: https://github.com/Dell-Networking/ansible-role-dellos-users
  name: dellos-users
- src: https://github.com/Dell-Networking/ansible-role-dellos-vlan
  name: dellos-vlan
- src: https://github.com/Dell-Networking/ansible-role-dellos-vlt
  name: dellos-vlt
- src: https://github.com/Dell-Networking/ansible-role-dellos-vrf
  name: dellos-vrf
- src: https://github.com/Dell-Networking/ansible-role-dellos-vrrp
  name: dellos-vrrp
- src: https://github.com/Dell-Networking/ansible-role-dellos-xstp
  name: dellos-xstp

EOF

```

Install the roles (doesn't work quite like on the [docs install page](https://ansible-dellos-docs.readthedocs.io/en/latest/install.html) says it should unless you create a proper yaml file):
```
ansible-galaxy install -r dellemc_roles.yml --roles-path roles/
```

Note, if you want to remove these roles you can do this:
```
ansible-galaxy list --roles-path roles/ | awk '{print $2}' | sed -e 's/,//' | xargs ansible-galaxy role remove  --roles-path roles/
```

The host config data for the imaginary datacenter switch config.
Make a directory to hold the configuration snippets
```
mkdir tmp/
```

Run the ansible to write the configuration for the switch.
This generates a config for a dellos9 and dellos10 switch.
```
ansible-playbook -i inventory.yaml datacenter.yaml
```

You can compare the output formats in the tmp/ dir.

Note the playbook is slightly altered from the CLOS fabric
example to use the local convention for role names and 
to add the flag to write the interface config.  It is 
this flag and  the fact that we can't reach any real switches 
with the given inventory and creditials that makes this a
config writing example.
