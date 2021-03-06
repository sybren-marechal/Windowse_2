---
description: The configuration of the IP-adresses
---

# IP configuration

## DOMAIN controller connection

### netwerk provider

Domain controller   
G0/1 WAN  
IP Address: 172.20.0.213  
SUBNET 255.255.0.0  
DEFAULT GATEWAY 172.20.0.1

### Eigen Netwerk

G0/2 LAN  
IP Address: 192.168.0.1  
255.255.255.0  
Def gateway 192.168.0.1  
DNS 192.168.0.1

## Member server

G0/1 LAN  
ip address: 192.168.0.2   
Subnet. 255.255.255.0  
def gateway 192.168.0.2   
DNS 192.168.0.2 

g0/2 to hyper-V via switch

## PC 1

G0/1 LAN

DHCP  
OR  
ip address: 192.168.0.10   
Subnet. 255.255.255.0  
def gateway 192.168.0.2   
DNS 192.168.0.2 

## VERDELING

192.168.0.1- 192.168.0.49 CONTROLLERS

####     USED IP ADDRESSES

* 192.168.0.1 Domain controller\(**Server1\)**
* 192.168.0.2 Member server **\(Server 2\)**
* 192.168.0.3 VCMSV1 **\(Virtuele Server 1\)**
* 192.168.0.4 VCMSV2 **\(Virtuele Server 2\)**
* 192.168.0.5 VCMSV3 **\(Virtuele Server 3\)**
* 192.168.0.6 VCMSV4 **\(Virtuele Server 4\)**
* 192.168.0.7 VCMSV5 **\(Virtuele Server 5\)**
* 192.168.0.8 \(**IDRAC\)** 

192.168.0.50 - 192.168.0.179 COMPUTERS  
192.168.0.180 - 192.168.0.254 PRINTERS

The scheme with ip configuration

![Schema with ip configuration](.gitbook/assets/schema16okt.png)



