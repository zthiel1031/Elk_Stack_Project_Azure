# azure-red-team Lab Day 2


**Description:** This is an architectural overview of  a Red-Team demo cloud infrastructure that includes a jump-box and 2 servers running containers that feed logs to a machine running ELK stack.

- [x] Docker is installed and running on the Jump-box.
- [x] The cyberxsecurity/ansible Docker container is running on the jump-box.
- [x] The security group has a rule that allows the jump-box ssh access to the vNet.
- [x] An ssh key created from inside the Ansible container that has no password.
- [x] The Web VMs password has been reset using the ssh key from the Ansible container.
- [x] Ansible is able to make a connection to both Web VMs.

Visit `whatsmyip.org` to determine your public facing IP from the space you will be accessing your cloud environment

```
whatsmyip.org
```
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

**(NEW)**
**Applications**
- Install the following applications:
> - `docker.io`
```bash
sudo apt update
# sudo su # switch to the root user so you don't have to keep 'sudoing'
sudo apt install docker.io # Install Docker.io application
sudo systemctl status docker # Verify Docker service is running
# sudo systemctl start docker # Execute if service is not running
sudo docker pull cyberxsecurity/ansible:latest bash
docker run -ti cyberxsecurity/ansible:latest bash
exit
```

**Docker Container**
e770794cdd79

**- Virtual Machine Name: web-1**
- Region: Australia East
- Availability Options: Availability set
- Availability Set: red-set1
- Security type: standard
- Image: Ubuntu Server 18.04 LTS -Gen2
- Size: Standard_B1ms - 1vcpu, 2GiB memory
- Authentication type: SSH public key
- SSH pubic key: 
**Networking**
- IP: 10.0.0.5
- NIC network security group: Advanced
- NIC SG: red-sg1
**Users**
- Admin: redadmin
- Authentication: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD6dBICNbpnsfWHBsS+IRerhaUI3og5P+VWb/nG3dsJmM1h5VIWtPtK8GyFI/lPZcmCV71aCHfe/vKiW52ugbm0vB4MzwgawaKVfkp9pULBtDnVz3ShoHFBzFMEENImX2Rq0n/n6BMh9MHaQveMyIGbbh8syyr9WRu23nwTmCrDAYxEmWgjasicDw05OsKr57QtGnWiQgQ8pLUzguFKuRwSN5gw9tOHwl0vyBWDazCrlbkx4S/bjzHVKVQMvgh2rEUTUnUeb2cbwOverFLDxqI+ZnOZYK5qVG56ozzzQB3/FLbOkbW3EDZTuOezO1wOPvX8UVfPdXGpV06lk/O7b40UTTKqqukXq61Pgii4EAsjlq4yS463Mo3LIEPpBuYXM3Vjzwjjf706XZAan6VN5x+3RItXzJ0ifRME8SSeZEXsSlj5TNtpO1lH0nzcW54sZE52Pf2ydrRQTDYzusa7ydZm2xixDcxnxKFpyGnsiu3X8RpnWpciiLyuB8MRhxSUVms= root@e770794cdd79

**- Virtual Machine Name: web-2**
- Region: Australia East
- Availability Options: Availability set
- Availability Set: red-set1
- Security type: standard
- Image: Ubuntu Server 18.04 LTS -Gen2
- Size: Standard_B1ms - 1vcpu, 2GiB memory
- Authentication type: SSH public key
- SSH pubic key: ???
**Networking**
- IP: 10.0.0.6
- NIC network security group: Advanced
- NIC SG: red-sg1
**Users**
- Admin: redadmin
- Authentication: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD6dBICNbpnsfWHBsS+IRerhaUI3og5P+VWb/nG3dsJmM1h5VIWtPtK8GyFI/lPZcmCV71aCHfe/vKiW52ugbm0vB4MzwgawaKVfkp9pULBtDnVz3ShoHFBzFMEENImX2Rq0n/n6BMh9MHaQveMyIGbbh8syyr9WRu23nwTmCrDAYxEmWgjasicDw05OsKr57QtGnWiQgQ8pLUzguFKuRwSN5gw9tOHwl0vyBWDazCrlbkx4S/bjzHVKVQMvgh2rEUTUnUeb2cbwOverFLDxqI+ZnOZYK5qVG56ozzzQB3/FLbOkbW3EDZTuOezO1wOPvX8UVfPdXGpV06lk/O7b40UTTKqqukXq61Pgii4EAsjlq4yS463Mo3LIEPpBuYXM3Vjzwjjf706XZAan6VN5x+3RItXzJ0ifRME8SSeZEXsSlj5TNtpO1lH0nzcW54sZE52Pf2ydrRQTDYzusa7ydZm2xixDcxnxKFpyGnsiu3X8RpnWpciiLyuB8MRhxSUVms= root@e770794cdd79
