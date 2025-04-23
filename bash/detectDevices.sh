#!/bin/bash

# To use you need to give the netwok interface ./detectDevices.sh wlan0 

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
ORANGE='\033[0;33m'
NC='\033[0m'

# Check if the the netwok interface was provide
if [ -z $1 ]; then
  echo -e "${RED}Usage: $0 <network_interface>${NC}"
  exit 1
fi

INTERFACE=$1

# Scanning the local netwok with arp-scan and extract the MAC Address
echo -e "${BLUE}SCANING THE LOCAL NETWORK USING INTERFACE: $INTERFACE...${NC}"
DEVICES=$(sudo arp-scan --interface=wlan0 --localnet | awk '{print $1 " " $2}' | grep -E "([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+) ([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}")

# Exit if no devices in the netwok
if [ -z "$DEVICES" ]; then
    echo -e "${ORANGE}No devices found on the netwok.${NC}"
    exit 1
fi

echo -e "${YELLOW}Detected devices:${NC}"

while read -r ip mac; do
  echo -e "${GREEN} [+] IP: $ip - MAC: $mac ${NC}"
done <<< "$DEVICES"


# Look up the vendors using the MAC Vendors API
echo -e "${YELLOW}Looking up device vendors...${NC}"
while read -r ip mac; do
    VENDOR=$(curl -s "https://api.macvendors.com/$mac")
    FVENDOR=1
    # If the API blocks the request, display a warning
    if [ -z "$VENDOR" ] || echo "$VENDOR" | grep -qiE "Too Many Requests|Not Found"; then
        VENDOR="Query limit reached, try again later."
        echo -e "${ORANGE} [?] IP: $ip - MAC: $mac - Vendor: $VENDOR ${NC}"
    else
        echo -e "${GREEN} [+] IP: $ip - MAC: $mac - Vendor: $VENDOR ${NC}"
    fi

    sleep 4
done <<< "$DEVICES"

