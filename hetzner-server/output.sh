#!/bin/bash

# Load the output values from the outputs file
source outputs.tf

# Perform a test using the server IP
echo "Server with IP: $server_ip"
echo "You can connect to your fresh server with the following command"
echo "ssh root@$server_ip"
echo "and you can configure your server whatever you want"


# Add your test logic here
# For example, you can use the server IP to SSH into the server and run commands
# ssh user@$server_ip 'command'
