#!/bin/sh

wget -qO- https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz | tar -xz

chmod +x node_exporter-1.6.1.linux-amd64/node_exporter
sudo mv node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin
