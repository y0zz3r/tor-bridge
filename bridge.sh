#!/bin/bash

# Update the package list and upgrade installed packages
sudo apt update
sudo apt upgrade -y

# Install Tor
sudo apt install tor -y

# Backup the original Tor configuration file
sudo cp /etc/tor/torrc /etc/tor/torrc.bak

# Configure the Tor bridge settings
echo "BridgeRelay 1" | sudo tee -a /etc/tor/torrc
echo "ORPort 443" | sudo tee -a /etc/tor/torrc
echo "Nickname <your_bridge_nickname>" | sudo tee -a /etc/tor/torrc
echo "ContactInfo <your_email_address>" | sudo tee -a /etc/tor/torrc
echo "ExitPolicy reject *:*" | sudo tee -a /etc/tor/torrc
echo "Log notice file /var/log/tor/notices.log" | sudo tee -a /etc/tor/torrc

# Restart Tor
sudo systemctl restart tor
