#!/bin/bash 

# Escanea la ip que le pases para ver que puertos tiene activos con dos commandos
# comando 1: sudo nmap -p- --open -sT --min-rate 5000 -vvv -n -Pn ip -oG allPorts
# comando 2: nmap -sC -sV ip
# Verificamos que se paso una ip

if [ -z "$1" ]; then
  echo "Scanning: $0 <IP>"
  exit 1
fi

IP=$1

echo "Scanning all the ports for $IP ...."

sudo nmap -p- --open -sT --min-rate 5000 -vvv -n -Pn "$1"

PORTS=$(grep -oP '\d+/open' allPorts | cut -d '/' -f1 | paste -sd, -)

if [ -z "$PORTS" ]; then
  echo "Not found open ports"
  exit 0
fi

echo -e "\nOpen ports detected: $PORTS"
echo -e "\nScanning details..."

nmap -sC -sV -p"$PORTS" "$IP"
