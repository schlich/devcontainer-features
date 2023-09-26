#!/bin/sh

sudo apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_10.1.2_amd64.deb
sudo dpkg -i grafana-enterprise_10.1.2_amd64.deb