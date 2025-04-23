#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'

if [ "$#" -lt 3 ] || [ "$#" -gt 4 ]; then
  echo -e "${YELLOW}Uso: $0 <IP> <PUERTO_INICIAL> <PUERTO_FINAL> [TIMEOUT]${NC}"
  echo -e "Ejemplo: ${GREEN}$0 192.168.1.1 20 1000${NC} (timeout por defecto: 1s)"
  echo -e "Ejemplo: ${GREEN}$0 192.168.1.1 20 1000 2${NC} (timeout personalizado: 2s)"
  exit 1
fi

IP=$1
PORT_START=$2
PORT_END=$3
TIMEOUT_VAL=${4:-1}

echo -e "${BLUE}Scaning ports open in $IP...${NC}"

for port in $(seq $PORT_START $PORT_END); do 
  (timeout $TIMEOUT_VAL bash -c "echo >/dev/tcp/$IP/$port") 2>/dev/null && {
    service=$(nc -v -z -w $TIMEOUT_VAL $IP $port 2>&1 | grep "succeeded" | awk '{print $4}')
    echo -e "${GREEN}[+] Port $port open - Service: ${service:-Unknow}${NC}"
  } &
done
wait
