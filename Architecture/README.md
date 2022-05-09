# Azure Red Team Architecture

**Description:** This is an architectural overview of  a Red-Team demo cloud infrastructure that includes a jump-box and 3 servers running containers that feed logs to a machine running ELK stack.

Home Network IP: 67.149.9.102

### Resource Groups:

- Resource Group: red-team
- Region: Australia East

### Virtual Networks

- Virtual Network:red-net1
- Region: Australia east
- Resource Group: red-team
- Base: 10.0.0.0/16
- Subnet: 10.0.0.0/24
- Peerings: Red-to-Elk
- Peer to: Elk-Net


- Virtual Network:Elk-Net
- Region: Japan East
- Resource Group: red-team
- Base: 10.1.0.0/16
- Subnet: 10.1.0.0/24
- Peerings: Elk-to-red
- Peer to: red-net1
### Network Security Groups

- Name:red-sg1
- Region: Australia east
- Resource Group: red-team


### Inbound Security Rules

- Name: external-inbound-deny-all
- Priority: 4096
- Source: Any
- Port: *
- Destination: Any
- Port: *
- Protocol: Custom
- Action: Deny

**(NEW)**
- Name: allow-SSH-from-jump
- Priority: 4095
- Source: *
- Port: *
- Destination: 
- Port: 22
- Protocol: SSH
- Action: Allow

**(NEW)**
- Name: allow-ssh-home-jump
- Priority: 4094
- Source: 67.149.9.102
- Port: *
- Destination: IP Adress
- Destination IP: 20.211.126.142
- Port: 22
- Protocol: SSH
- Action: Allow


## Virtual Machines:
**- Virtual Machine Name: red-jump1**
  - Region: Australia East
  - Availability Options: No infrastructure redundancy required
  - Security type: standard
  - Image: Ubuntu Server 18.04 LTS -Gen2
  - Size: Standard_B1s - 1vcpu, 1GiB memory
  - Authentication type: SSH public key
  - SSH pubic key: ???
**Networking**
  - Name: red-jum1-ip
  - Type: Public
  - IP4: 20.101.81.160
  - SKU: Basic
  - Assignment: Static
  - NIC network security group: Advanced
  - NIC SG: Red-SG1
**(NEW)**
  - Type: Private
  - IP4: 10.0.0.4
  - Assignment: Static

**Users**
- Admin: redadmin
- Authentication: Public Key

**- Virtual Machine Name: web-1**
- Region: Australia East
- Availability Options: Availability set
- Availability Set: red-set1
- Security type: standard
- Image: Ubuntu Server 18.04 LTS -Gen2
- Size: Standard_B1ms - 1vcpu, 2GiB memory
- Authentication type: SSH public key
- SSH pubic key: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD6dBICNbpnsfWHBsS+IRerhaUI3og5P+VWb/nG3dsJmM1h5VIWtPtK8GyFI/lPZcmCV71aCHfe/vKiW52ugbm0vB4MzwgawaKVfkp9pULBtDnVz3ShoHFBzFMEENImX2Rq0n/n6BMh9MHaQveMyIGbbh8syyr9WRu23nwTmCrDAYxEmWgjasicDw05OsKr57QtGnWiQgQ8pLUzguFKuRwSN5gw9tOHwl0vyBWDazCrlbkx4S/bjzHVKVQMvgh2rEUTUnUeb2cbwOverFLDxqI+ZnOZYK5qVG56ozzzQB3/FLbOkbW3EDZTuOezO1wOPvX8UVfPdXGpV06lk/O7b40UTTKqqukXq61Pgii4EAsjlq4yS463Mo3LIEPpBuYXM3Vjzwjjf706XZAan6VN5x+3RItXzJ0ifRME8SSeZEXsSlj5TNtpO1lH0nzcW54sZE52Pf2ydrRQTDYzusa7ydZm2xixDcxnxKFpyGnsiu3X8RpnWpciiLyuB8MRhxSUVms= root@e770794cdd79
**Networking**
- IP: 10.0.0.5
- NIC network security group: Advanced
- NIC SG: red-sg1
**Users**
- Admin: redadmin
- Authentication: Public key 

**- Virtual Machine Name: web-2**
- Region: Australia East
- Availability Options: Availability set
- Availability Set: red-set1
- Security type: standard
- Image: Ubuntu Server 18.04 LTS -Gen2
- Size: Standard_B1ms - 1vcpu, 2GiB memory
- Authentication type: SSH public key
- SSH pubic key: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD6dBICNbpnsfWHBsS+IRerhaUI3og5P+VWb/nG3dsJmM1h5VIWtPtK8GyFI/lPZcmCV71aCHfe/vKiW52ugbm0vB4MzwgawaKVfkp9pULBtDnVz3ShoHFBzFMEENImX2Rq0n/n6BMh9MHaQveMyIGbbh8syyr9WRu23nwTmCrDAYxEmWgjasicDw05OsKr57QtGnWiQgQ8pLUzguFKuRwSN5gw9tOHwl0vyBWDazCrlbkx4S/bjzHVKVQMvgh2rEUTUnUeb2cbwOverFLDxqI+ZnOZYK5qVG56ozzzQB3/FLbOkbW3EDZTuOezO1wOPvX8UVfPdXGpV06lk/O7b40UTTKqqukXq61Pgii4EAsjlq4yS463Mo3LIEPpBuYXM3Vjzwjjf706XZAan6VN5x+3RItXzJ0ifRME8SSeZEXsSlj5TNtpO1lH0nzcW54sZE52Pf2ydrRQTDYzusa7ydZm2xixDcxnxKFpyGnsiu3X8RpnWpciiLyuB8MRhxSUVms= root@e770794cdd79
**Networking**
- IP: 10.0.0.6
- NIC network security group: Advanced
- NIC SG: red-sg1
**Users**
- Admin: redadmin
- Authentication: Public Key

**- Virtual Machine Name: web-3**
- Region: Australia East
- Availability Options: Availability set
- Availability Set: red-set1
- Security type: standard
- Image: Ubuntu Server 18.04 LTS -Gen2
- Size: Standard_B1ms - 1vcpu, 2GiB memory
- Authentication type: SSH public key
- SSH pubic key: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD6dBICNbpnsfWHBsS+IRerhaUI3og5P+VWb/nG3dsJmM1h5VIWtPtK8GyFI/lPZcmCV71aCHfe/vKiW52ugbm0vB4MzwgawaKVfkp9pULBtDnVz3ShoHFBzFMEENImX2Rq0n/n6BMh9MHaQveMyIGbbh8syyr9WRu23nwTmCrDAYxEmWgjasicDw05OsKr57QtGnWiQgQ8pLUzguFKuRwSN5gw9tOHwl0vyBWDazCrlbkx4S/bjzHVKVQMvgh2rEUTUnUeb2cbwOverFLDxqI+ZnOZYK5qVG56ozzzQB3/FLbOkbW3EDZTuOezO1wOPvX8UVfPdXGpV06lk/O7b40UTTKqqukXq61Pgii4EAsjlq4yS463Mo3LIEPpBuYXM3Vjzwjjf706XZAan6VN5x+3RItXzJ0ifRME8SSeZEXsSlj5TNtpO1lH0nzcW54sZE52Pf2ydrRQTDYzusa7ydZm2xixDcxnxKFpyGnsiu3X8RpnWpciiLyuB8MRhxSUVms= root@e770794cdd79
**Networking**
- IP: 10.0.0.7
- NIC network security group: Advanced
- NIC SG: red-sg1
**Users**
- Admin: redadmin
- Authentication: Public Key

**- Virtual Machine Name: web-3**
- Region: Japan East
- Availability Options: Availability set
- Availability Set: red-set1
- Security type: standard
- Image: Ubuntu Server 18.04 LTS -Gen2
- Size: Standard_B2s - 2vcpu, 4GiB memory
- Authentication type: SSH public key
- SSH pubic key: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD6dBICNbpnsfWHBsS+IRerhaUI3og5P+VWb/nG3dsJmM1h5VIWtPtK8GyFI/lPZcmCV71aCHfe/vKiW52ugbm0vB4MzwgawaKVfkp9pULBtDnVz3ShoHFBzFMEENImX2Rq0n/n6BMh9MHaQveMyIGbbh8syyr9WRu23nwTmCrDAYxEmWgjasicDw05OsKr57QtGnWiQgQ8pLUzguFKuRwSN5gw9tOHwl0vyBWDazCrlbkx4S/bjzHVKVQMvgh2rEUTUnUeb2cbwOverFLDxqI+ZnOZYK5qVG56ozzzQB3/FLbOkbW3EDZTuOezO1wOPvX8UVfPdXGpV06lk/O7b40UTTKqqukXq61Pgii4EAsjlq4yS463Mo3LIEPpBuYXM3Vjzwjjf706XZAan6VN5x+3RItXzJ0ifRME8SSeZEXsSlj5TNtpO1lH0nzcW54sZE52Pf2ydrRQTDYzusa7ydZm2xixDcxnxKFpyGnsiu3X8RpnWpciiLyuB8MRhxSUVms= root@e770794cdd79
**Networking**
- IP: 10.1.0.5
- NIC network security group: Advanced
- NIC SG: red-sg1
**Users**
- Admin: elkadmin
- Authentication: Public Key

**Load Balancer**
- Resource group: red-team
- Name: red-LB
- Region: Australia East
- SKU:Basic
- Tier: Regional
- Type: Public

- Frontend IP configuration name: red-LB
- Frontend IP configuration IP address: To be created

- Backend pool name: web-servers
- Inbound rules: None
- Outbound rules: None
- Tags: Team:red-team

**Load Blancing Rule**
- Name: red-pool
- IP version: IPV4
- Frontend IP: red-LB
- Backend pool: webservers
- Protocol: TCP
- Port: 80
- Backend Port: 80

**Docker Container**
- e770794cdd79: keen_roentgen