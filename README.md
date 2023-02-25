Tor Bridge Setup Script
-----------------------

This Bash script automates the process of setting up a Tor bridge on a Debian 11 server while also changing the SSH port to a random value.

### Features

*   Prompts user to enter a nickname for the Tor bridge
*   Generates a random SSH port number between 1024 and 65535 using the `shuf` command
*   Updates package repository and installs necessary packages for Tor and firewall configuration
*   Configures firewall to deny incoming traffic by default, allow outgoing traffic by default, and allow incoming traffic on the new SSH port and outgoing traffic on the default Tor port (9001)
*   Adds the Tor Project signing key and repository to the package manager
*   Updates the package repository again and installs the latest version of Tor
*   Configures Tor to use the user-provided bridge nickname and the default port for bridges (443)
*   Configures the bridge to reject all exit traffic
*   Changes the SSH port to the randomly generated port number
*   Restarts the SSH and Tor services to apply the changes
*   Displays the Tor bridge fingerprint and bandwidth information, which can be used to register the bridge with the Tor network, as well as the newly generated SSH port number

### Usage

To use this script, simply download the `tor_bridge_setup.sh` file and run it in your Debian 11 server with:

`sudo bash tor_bridge_setup.sh`

You will be prompted to enter a nickname for your Tor bridge, and the script will guide you through the rest of the setup process.

### License

This script is licensed under the MIT License.
