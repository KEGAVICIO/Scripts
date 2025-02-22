#!/bin/bash

# Escanea la red local con arp-scan y extrae las direcciones MAC
echo "Escaneando la red local..."
dispositivos=$(sudo arp-scan --interface=wlan0 --localnet | awk '{print $1 " " $2}' | grep -E "([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+) ([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}")

# Si no se encontraron dispositivos, salir
if [ -z "$dispositivos" ]; then
    echo "No se encontraron dispositivos en la red."
    exit 1
fi

echo "Dispositivos detectados:"
echo "$dispositivos"

# Buscar los fabricantes de las direcciones MAC usando la API de Mac Vendors
echo ""
echo "Buscando fabricantes de dispositivos..."
while read -r ip mac; do
    fabricante=$(curl -s "https://api.macvendors.com/$mac")
    
    # Si la API bloquea la petición, mostrar mensaje de espera
    if echo "$fabricante" | grep -q "Too Many Requests"; then
        fabricante="Límite de consultas alcanzado, intenta más tarde."
    fi

    echo "IP: $ip - MAC: $mac - Fabricante: $fabricante"
    sleep 4
done <<< "$dispositivos"

