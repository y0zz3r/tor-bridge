#!/bin/bash

set -e

# Define variables
TOR_KEYRING="/usr/share/keyrings/torproject-archive-keyring.gpg"
TOR_LIST="/etc/apt/sources.list.d/tor.list"
TORRC="/etc/tor/torrc"
SSHD_CONFIG="/etc/ssh/sshd_config"

# Prompt user for bridge nickname
read -p "Enter a nickname for your Tor bridge: " nickname

# Generate random SSH port number between 1024 and 65535
ssh_port=$(shuf -i 1024-65535 -n 1)

# Update package repository and install necessary packages
apt update
apt install -y tor ufw

# Configure firewall
ufw default deny incoming
ufw default allow outgoing
ufw allow $ssh_port/tcp
ufw allow 9001/tcp
ufw --force enable

# Add Tor Project signing key and repository to package manager
curl -fsSL https://deb.torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee $TOR_KEYRING >/dev/null 2>&1
echo "deb [signed-by=$TOR_KEYRING] https://deb.torproject.org/torproject.org $(lsb_release -cs) main" | tee $TOR_LIST >/dev/null 2>&1
apt update

# Configure Tor bridge with user-provided nickname and default port for bridges (443)
echo "BridgeRelay 1" >> $TORRC
echo "BridgeNickname $nickname" >> $TORRC
echo "ORPort 443" >> $TORRC
echo "ExitPolicy reject *:*" >> $TORRC

# Change SSH port to random port number
sed -i "s/^#Port 22/Port $ssh_port/" $SSHD_CONFIG

# Restart SSH and Tor services
systemctl restart sshd
systemctl restart tor

# Display Tor bridge fingerprint and bandwidth information, as well as the new SSH port number
echo "Your Tor bridge fingerprint and bandwidth information:"
cat /var/lib/tor/fingerprint
echo "Your new SSH port number is $ssh_port"
