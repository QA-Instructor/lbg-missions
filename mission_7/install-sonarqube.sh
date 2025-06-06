#!/bin/bash

echo "updating and installing dependencies"
sudo apt update
sudo apt install -y default-jre wget git zip unzip > /dev/null
echo "configuring sonar user"
sudo useradd -m -s /bin/bash sonar
echo "downloading Long Term Active stable sonar zip"
sudo su - sonar -c "wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-25.5.0.107428.zip"
echo "unpack sonar scripts"
sudo su - sonar -c "unzip sonarqube-25.5.0.107428.zip"
echo "setting up sonar service"
sudo tee /etc/systemd/system/sonar.service << EOF > /dev/null
[Unit]
Description=SonarQube Server
[Service]
User=sonar
WorkingDirectory=/home/sonar
ExecStart=/home/sonar/sonarqube-25.5.0.107428/bin/linux-x86-64/sonar.sh console
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable sonar
sudo systemctl restart sonar