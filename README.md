# Elk Stack Project in Azure
---

**Description:** This is an architectural overview of  a Red-Team demo cloud infrastructure that includes a jump-box and 3 servers running containers that feed logs to a machine running ELK stack.

![](https://github.com/zthiel1031/Elk_Stack_Project_Azure/blob/main/Architecture/Network%20Diagram/diagram.drawio%20(1).png?raw=true)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the yml and config file may be used to install only certain pieces of it, such as Filebeat.

- [Ansible Playbooks](https://github.com/zthiel1031/Elk_Stack_Project_Azure/tree/main/Ansible)
- [Docker](https://github.com/zthiel1031/Elk_Stack_Project_Azure/tree/main/Ansible/Docker)
- [ELK Stack](https://github.com/zthiel1031/Elk_Stack_Project_Azure/tree/main/Ansible/ELK%20Stack)
- [Filebeat](https://github.com/zthiel1031/Elk_Stack_Project_Azure/tree/main/Ansible/Filebeat)
- [Metricbeat](https://github.com/zthiel1031/Elk_Stack_Project_Azure/tree/main/Ansible/Metricbeat)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
    - Beats in Use
    - Machines Being Monitored


### Description of the Topology
---

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.
Load balancing ensures that the application will be highly functional and available, in addition to restricting traffic to the network.

- **What aspect of security do load balancers protect?**
    - Load balancers add resiliency by rerouting live traffic from one server to another if a server falls prey to a DDoS attack or otherwise becomes unavailable.

- **What is the advantage of a jump box?**
    - A Jump Box is also important as it prevents Azure VMs from being exposed via public IP Addresses. This allows us to do monitoring and logging on a single box. We can also restrict the IP addresses able to communicate with the Jump Box, as we've done here.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the **_network_** and system **_system logs_**.

- **What does Filebeat watch for?**
    - Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing.

- **What does Metricbeat record?**
    - Metricbeat takes the metrics and statistics that it collects and ships them to the output that you specify, such as Elasticsearch or Logstash.

The configuration of the machines are in the table below.

| Name              | Function        | IP Address               | Operating System   |
|-------------------|-----------------|--------------------------|--------------------|
| Jump Box          | Gateway         | 20.211.126.142           | Linux              |
| Web-1             | UbuntuServer    | 10.0.0.5                 | Linux              |
| Web-2             | UbuntuServer    | 10.0.0.6                 | Linux              |
| Web-3             | UbuntuServer    | 10.0.0.7                 | Linux              |
| Elk-Vm1.1         | UbuntuServer    | 10.1.0.5                 | Linux              |

### **Access Policies**
---
The machines on the internal network are not exposed to the public Internet. 

Only the jump box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP address:
- 67.149.9.102

Machines within the network can only be accessed by the jump box machine from the following IP:
- 20.211.126.142

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | No  (only from)     | 67.149.9.102         |
| Web-1    | No                  | 10.0.0.4 on port 22  |
| Web-2    | No                  | 10.0.0.4 on port 22  |
| Web-3    | No                  | 10.0.0.4 on port 22  |
| Elk-Vm1.1| No                  | 67.149.9.102 TCP 5601|

### Elk Configuration
---
**Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...**
- Using ansible playbooks allow each downloads and configuration is running through each steps and if a step had a problem that involved within a certain point then troubleshooting becomes a lot easier to deal with. This allows me to also rerun through specific installation without multiple programs being downloaded if a certain program has already installed due to the nature of ansible playbooks.

The playbook implements the following tasks:
The playbook implements the following tasks:
- Download a container program, we used docker.io to create containers 
```
sudo apt install docker.io
    sudo systemctl status docker #This allows us to see if it is running.
        # If it is not running use: sudo systemctl start docker
```

- Then download a image using 'sudo docker pull'
- We downloaded specific containers from a docker hub using: 
```
  sudo docker pull cyberxsecurity/ubuntu:bionic
      sudo docker run -ti bionic/ubuntu bash #this will allow us to run it
```
- Now that we have created a container we can run ansible (by just writing ansible in to the command)
- We added our private ip's of our webservers in to hosts, and changed the remote_user in ansible.cfg to match the admin username. This is a must if we want to connect our playbooks to our webservers.

**The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.**

![](https://github.com/zthiel1031/Elk_Stack_Project_Azure/blob/main/Architecture/Output_SS/docker_container.JPG?raw=true)

### Target Machines & Beats
**This ELK server is configured to monitor the following machines:**
- -The ELK monitors the three web servers (web-1: 10.0.0.5, web-2: 10.0.0.6, web-3: 10.0.0.7)

**We have installed the following Beats on these machines:**
- Filebeats
- Metricbeat

**These Beats allow us to collect the following information from each machine:**
- The beats allows us to see logs of what are written in the local syslong. As well as keeping a metric record of the operating system and services.