#!/usr/bin/env bash
# Get the name of any running OpenVPN service
running_service=$(systemctl list-units --type=service --state=running | grep 'openvpn-' | awk '{print $1}' | sed 's/.service//')

if [ -z "$running_service" ]; then
    echo "VPN: OFF"
else
    # Extract the name part after 'openvpn-'
    service_name=${running_service#openvpn-}
    echo "VPN: $service_name"
fi

