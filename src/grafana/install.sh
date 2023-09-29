#!/bin/sh

wget -wO- https://dl.grafana.com/enterprise/release/grafana-enterprise-10.1.2.linux-amd64.tar.gz | tar -xz
sudo mv grafana-10.1.2/bin/grafana /usr/local/bin