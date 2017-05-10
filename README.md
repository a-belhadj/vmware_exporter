# vmware_exporter
VMWare VCenter Exporter for Prometheus.

Get VMWare VCenter information:
- Current number of active snapshots
- Snapshot Unix timestamp creation date
- Datastore size and other stuff
- Basic VM and Host metrics

## Usage

- Create a `config.yml` file based on the `config.yml.sample`.
- Run `$ python vmware_exporter.py`
- Go to http://localhost:8000/metrics to see metrics

## Current Status

- Only VCenter 6 and 6.5 have been tested.
- VM information, Snapshot, Host and Datastore basic information is exported, i.e:
```
# HELP vmware_snapshots VMWare current number of existing snapshots
# TYPE vmware_snapshot_count gauge
vmware_snapshot_timestamp_seconds{vm_name="My Super Virtual Machine"} 2.0
# HELP vmware_snapshot_timestamp_seconds VMWare Snapshot creation time in seconds
# TYPE vmware_snapshot_timestamp_seconds gauge
vmware_snapshot_age{vm_name="My Super Virtual Machine",vm_snapshot_name="Very old snaphot"} 1478146956.96092
vmware_snapshot_age{vm_name="My Super Virtual Machine",vm_snapshot_name="Old snapshot"} 1478470046.975632

# HELP vmware_datastore_capacity_size VMWare Datasore capacity in bytes
# TYPE vmware_datastore_capacity_size gauge
vmware_datastore_capacity_size{ds_name="ESX1-LOCAL"} 67377299456.0
# HELP vmware_datastore_freespace_size VMWare Datastore freespace in bytes
# TYPE vmware_datastore_freespace_size gauge
vmware_datastore_freespace_size{ds_name="ESX1-LOCAL"} 66349694976.0
# HELP vmware_datastore_uncommited_size VMWare Datastore uncommitted in bytes
# TYPE vmware_datastore_uncommited_size gauge
vmware_datastore_uncommited_size{ds_name="ESX1-LOCAL"} 0.0
# HELP vmware_datastore_provisoned_size VMWare Datastore provisoned in bytes
# TYPE vmware_datastore_provisoned_size gauge
vmware_datastore_provisoned_size{ds_name="ESX1-LOCAL"} 1027604480.0
# HELP vmware_datastore_hosts VMWare Hosts number using this datastore
# TYPE vmware_datastore_hosts gauge
vmware_datastore_hosts{ds_name="ESX1-LOCAL"} 1.0
# HELP vmware_datastore_vms VMWare Virtual Machines number using this datastore
# TYPE vmware_datastore_vms gauge
vmware_datastore_vms{ds_name="ESX1-LOCAL"} 0.0

# HELP vmware_host_power_state VMWare Host Power state (On / Off)
# TYPE vmware_host_power_state gauge
vmware_host_power_state{host_name="esx1.company.com"} 1.0
# HELP vmware_host_cpu_usage VMWare Host CPU usage in Mhz
# TYPE vmware_host_cpu_usage gauge
vmware_host_cpu_usage{host_name="esx1.company.com"} 2959.0
# HELP vmware_host_cpu_max VMWare Host CPU max availability in Mhz
# TYPE vmware_host_cpu_max gauge
vmware_host_cpu_max{host_name="esx1.company.com"} 28728.0
# HELP vmware_host_memory_usage VMWare Host Memory usage in Mbytes
# TYPE vmware_host_memory_usage gauge
vmware_host_memory_usage{host_name="esx1.company.com"} 107164.0
# HELP vmware_host_memory_max VMWare Host Memory Max availability in Mbytes
# TYPE vmware_host_memory_max gauge
vmware_host_memory_max{host_name="esx1.company.com"} 131059.01953125
```

## References

The VMWare exporter uses 2 libraries:
- [pyVmomi](https://github.com/vmware/pyvmomi) for VMWare connection
- Prometheus [client_python](https://github.com/prometheus/client_python) for Prometheus supervision

The initial code is mainly inspired from:
- https://www.robustperception.io/writing-a-jenkins-exporter-in-python/
- https://github.com/vmware/pyvmomi-community-samples
- https://github.com/jbidinger/pyvmomi-tools

## License

See LICENSE file