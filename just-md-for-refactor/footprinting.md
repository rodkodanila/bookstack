# Footprinting

## Certificate details
```bash
curl -s https://crt.sh/\?q\=inlanefreight.com\&output\=json | jq .
```
## Get unique subdomains
```bash
curl -s https://crt.sh/\?q\=inlanefreight.com\&output\=json | jq . | grep name | cut -d":" -f2 | grep -v "CN=" | cut -d'"' -f2 | awk '{gsub(/\\n/,"\n");}1;' | sort -u
```

## Enumirate DNS Records 
```bash
dig any inlanefreight.com
```

# FTP
## Find nmap scripts
```bash
find / -type f -name ftp* 2>/dev/null | grep scripts
```
```bash
sudo nmap -sV -p21 -sC -A 10.129.14.136
```

# SMB
## SMBclient - Connecting to the Share
```bash
smbclient -N -L //10.129.14.128
```
```bash
smbclient //10.129.14.128/notes
```

```bash
nmap 10.129.14.128 -sV -sC -p139,445
```
```bash
rpcclient -U "" 10.129.14.128
```
