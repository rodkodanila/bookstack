# Host Discovery

## Scan Network Range
```bash
nmap 10.129.2.0/24 -sn -oA tnet | grep for | cut -d" " -f5
```
-sn 	    Disables port scanning.
-oA tnet 	Stores the results in all formats starting with the name 'tnet'.

## Scan IP List
```bash
nmap -sn -oA tnet -iL hosts.lst | grep for | cut -d" " -f5
```
-sn 	    Disables port scanning.
-oA tnet 	Stores the results in all formats starting with the name 'tnet'.
-iL 	    Performs defined scans against targets in provided 'hosts.lst' list.

## Scan Multiple IPs
```bash
nmap -sn -oA tnet 10.129.2.18 10.129.2.19 10.129.2.20| grep for | cut -d" " -f5
# if ip in range
nmap -sn -oA tnet 10.129.2.18-20| grep for | cut -d" " -f5
```

## Scan Single IP
```bash
nmap 10.129.2.18 -sn -oA host 
```

### Determine if it is alive or not
```bash
nmap 10.129.2.18 -sn -oA host -PE --packet-trace 
```
-sn 	        Disables port scanning.
-oA host 	    Stores the results in all formats starting with the name 'host'.
-PE 	        Performs the ping scan by using 'ICMP Echo requests' against the target.
--packet-trace 	Shows all packets sent and received
```bash
nmap 10.129.2.18 -sn -oA host -PE --reason
```
--reason 	Displays the reason for specific result.
```bash
nmap 10.129.2.18 -sn -oA host -PE --packet-trace --disable-arp-ping 
```
--disable-arp-ping  Disable ARP requests and scan our target with the desired ICMP echo requests

# Host and Port Scanning

## Scanning Top 10 TCP Ports
```bash
nmap 10.129.2.28 --top-ports=10 
```
## Nmap - Trace the Packets
```bash
nmap 10.129.2.28 -p 21 --packet-trace -Pn -n --disable-arp-ping
```
-p 21 	            Scans only the specified port.
--packet-trace  	Shows all packets sent and received.
-n          	    Disables DNS resolution.
--disable-arp-ping 	Disables ARP ping.

## Discovering Open UDP Ports
```bash
nmap 10.129.2.28 -F -sU
```
-F  	Scans top 100 ports.
-sU 	Performs a UDP scan.

```bash
nmap 10.129.2.28 -sU -Pn -n --disable-arp-ping --packet-trace -p 137 --reason 
```
-sU 	            Performs a UDP scan.
-Pn 	            Disables ICMP Echo requests.
-n                 	Disables DNS resolution.
--disable-arp-ping 	Disables ARP ping.
--packet-trace 	    Shows all packets sent and received.
-p 137 	            Scans only the specified port.
--reason 	        Displays the reason a port is in a particular state.

## Version Scan
```bash
nmap 10.129.2.28 -Pn -n --disable-arp-ping --packet-trace -p 445 --reason  -sV
```
-sV 	Performs a service scan.

# Saving the Results

## Different Formats
Normal output (-oN) with the .nmap file extension
Grepable output (-oG) with the .gnmap file extension
XML output (-oX) with the .xml file extension
(-oA) to save the results in all formats

```bash
nmap 10.129.2.28 -p- -oA target
```


# Service Enumeration

## Service Version Detection
```bash
nmap 10.129.2.28 -p- -sV -v
```
-p- 	Scans all ports.
-sV 	Performs service version detection on specified ports.
-v 	    Increases the verbosity of the scan, which displays more detailed information.

## Banner Grabbing
### nmap
```bash
nmap 10.129.2.28 -p- -sV
```

### nc
```bash
nc -nv 10.129.2.28 25
```

# Nmap Scripting Engine

## Default Scripts
```bash
nmap <target> -sC
```

## Specific Scripts Category
```bash
nmap <target> --script <category>
```

## Defined Scripts
```bash
nmap <target> --script <script-name>,<script-name>,...
```

## Nmap - Aggressive Scan
```bash
nmap 10.129.2.28 -p 80 -A
```

# Performance

## Optimized RTT
```bash
nmap 10.129.2.0/24 -F --initial-rtt-timeout 50ms --max-rtt-timeout 100ms
```
-F                          Scans top 100 ports.
--initial-rtt-timeout 50ms 	Sets the specified time value as initial RTT timeout.
--max-rtt-timeout 100ms 	Sets the specified time value as maximum RTT timeout.

## Reduced Retries
```bash
nmap 10.129.2.0/24 -F --max-retries 0 | grep "/tcp" | wc -l
```
-F 	                Scans top 100 ports.
--max-retries 0 	Sets the number of retries that will be performed during the scan.

## Optimized Scan rates
```bash
nmap 10.129.2.0/24 -F -oN tnet.minrate300 --min-rate 300
```
-F 	                    Scans top 100 ports.
-oN tnet.minrate300 	Saves the results in normal formats, starting the specified file name.
--min-rate 300 	        Sets the minimum number of packets to be sent per second.

## Timing
-T 0 / -T paranoid
-T 1 / -T sneaky
-T 2 / -T polite
-T 3 / -T normal
-T 4 / -T aggressive
-T 5 / -T insane

```bash
nmap 10.129.2.0/24 -F -oN tnet.T5 -T 5
```

## SYN-Scan
```bash
nmap 10.129.2.28 -p 21,22,25 -sS -Pn -n --disable-arp-ping --packet-trace
```
## ACK-Scan
```bash
nmap 10.129.2.28 -p 21,22,25 -sA -Pn -n --disable-arp-ping --packet-trace
```
-sS 	Performs SYN scan on specified ports.
-sA 	Performs ACK scan on specified ports.

## Scan by Using Decoys
```bash
nmap 10.129.2.28 -p 80 -sS -Pn -n --disable-arp-ping --packet-trace -D RND:5
```
-D RND:5 	Generates five random IP addresses that indicates the source IP the connection comes from.

## Scan by Using Different Source IP
```bash
nmap 10.129.2.28 -n -Pn -p 445 -O -S 10.129.2.200 -e tun0
```
-O 	            Performs operation system detection scan.
-S 	            Scans the target by using different source IP address.
10.129.2.200 	Specifies the source IP address.
-e tun0 	    Sends all requests through the specified interface.

