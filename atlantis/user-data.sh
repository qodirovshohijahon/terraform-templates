#!/bin/bash
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update && sudo apt upgrade -y
sudo apt install default-jre -y
sudo apt install jenkins -y
sudo systemctl start jenkins
#!/bin/bash

# Update the system
sudo apt-get update -y

# Install Docker dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the system again with the Docker repository added
sudo apt-get update -y

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add the current user to the docker group to avoid using sudo for docker commands
sudo usermod -aG docker $USER

sudo chmod 666 /var/run/docker.sock

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker and Docker Compose installation
docker --version
docker-compose --version


sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg


gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint


echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform


# echo "--------------Install Atlantis--------"

# sudo apt install unzip

# wget https://github.com/runatlantis/atlantis/releases/download/v0.24.3/atlantis_linux_amd64.zip

# unzip atlantis_linux_amd64.zip

# sudo mv atlantis /usr/local/bin


# export URL="http://3.83.99.217"
# export SECRET="FFyivjgwbehggwwpuspffrqguyxjuupxgdrgurlgacfdqlayerylnmbqjyykkrxfkbvmuexqqigbxlrywukjyroswqcmxytflzewrkrootjtyhzaahkmqlstvysnjdki"
# export TOKEN="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"
# export USERNAME="qodirovshohijahon"
# export REPO_ALLOWLIST="github.com/qodirovshohijahon/demo" #GitHub example: REPO_ALLOWLIST="github.com/runatlantis/atlantis"

# Any environment variables required for auth
# export ="path-to-json-file"

# atlantis server \
# --atlantis-url="$URL" \
# --gh-user="$USERNAME" \
# --gh-token="$TOKEN" \
# --gh-webhook-secret="$SECRET" \
# --repo-allowlist="$REPO_ALLOWLIST" \
# --repo-config=repos.yaml