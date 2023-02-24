# tor-bridge

The script is a bash script designed to automate the process of setting up a Tor bridge on a Debian 11 server while also changing the SSH port to a random value. The script begins by prompting the user to enter a nickname for their Tor bridge, and then generates a random SSH port number between 1024 and 65535 using the shuf command.

The script then proceeds to update the package repository and install the necessary packages for Tor and firewall configuration. The firewall is configured to deny incoming traffic by default, allow outgoing traffic by default, and allow incoming traffic on the new SSH port and outgoing traffic on the default Tor port (9001).

Next, the script adds the Tor Project signing key and repository to the package manager, updates the package repository again, and installs the latest version of Tor. It then configures Tor to use the user-provided bridge nickname and the default port for bridges (443). It also configures the bridge to reject all exit traffic.

The script continues by changing the SSH port to the randomly generated port number, restarts the SSH and Tor services to apply the changes, and displays the Tor bridge fingerprint and bandwidth information, which can be used to register the bridge with the Tor network, as well as the newly generated SSH port number.

Overall, this script automates the process of setting up a Tor bridge on a Debian 11 server while also changing the SSH port to a random value to enhance security. This can be useful for individuals or organizations looking to contribute to the Tor network by hosting a bridge, while also protecting their server from potential attackers by changing the default SSH port.
