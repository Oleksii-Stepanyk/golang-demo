#!/bin/bash

sudo apt update -y
sudo apt install -y git
sudo apt install -y nginx
sudo apt install -y postgresql
sudo apt install -y golang

git clone https://github.com/Oleksii-Stepanyk/golang-demo.git
cd /golang-demo

export PGPASSWORD='1q2w3e4r'
psql -h ${rds_addr} -U postgres -p 5432 -f db_schema.sql

cd /golang-demo
sudo GOOS=linux GOARCH=amd64 go build -o golang-demo
sudo chmod +x golang-demo

sudo rm /etc/nginx/sites-available/default
cat << 'NGINX_CONF' | sudo tee /etc/nginx/sites-available/default
server {
    listen       80;
    server_name  localhost;

    location / {
        proxy_pass         http://localhost:8080;
        proxy_set_header   Host $host;
        proxy_set_header   X-Real-IP $remote_addr;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
    }
}
NGINX_CONF

touch golang.service

cat << 'EOF' | sudo tee golang.service
[Unit]
Description=Golang demo service

[Service]
Type=simple
Environment="DB_ENDPOINT=${rds_addr}" "DB_PORT=5432" "DB_USER=postgres" "DB_PASS=1q2w3e4r" "DB_NAME=db"
ExecStart=/golang-demo/golang-demo
Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

sudo cp golang.service /etc/systemd/system/golang.service
rm -f golang.service

sudo systemctl daemon-reload
sudo systemctl unmask golang
sudo systemctl start golang

sudo systemctl restart nginx
sudo systemctl enable golang
sudo systemctl enable nginx