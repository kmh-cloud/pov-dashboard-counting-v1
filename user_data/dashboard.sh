#!/bin/bash
exec > /var/log/dashboard-service.log 2>&1
set -x

echo "Starting dashboard service setup"

sudo apt update -y
sudo apt-get install -y net-tools zip unzip curl jq tree wget siege apt-transport-https ca-certificates software-properties-common gnupg lsb-release

# Download & install dashboard binary
sudo curl -L https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/dashboard-service_linux_amd64.zip -o dashboard-service.zip
sudo unzip dashboard-service.zip
sudo rm -rf dashboard-service.zip
sudo mv dashboard-service_linux_amd64 /usr/bin/dashboard-service
sudo chmod 755 /usr/bin/dashboard-service
sudo chown ubuntu:ubuntu /usr/bin/dashboard-service

# Create systemd service
sudo cat > /usr/lib/systemd/system/dashboard-api.service << 'EOF'
[Unit]
Description=Dashboard API service
After=syslog.target network.target

[Service]
Environment=PORT="9005"
Environment=COUNTING_SERVICE_URL="http://${counting_private_ip}:9005"
ExecStart=/usr/bin/dashboard-service
User=ubuntu
Group=ubuntu
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable dashboard-api.service
sudo systemctl start dashboard-api.service
sudo systemctl status dashboard-api.service
sudo lsof -i -P | grep dashboard