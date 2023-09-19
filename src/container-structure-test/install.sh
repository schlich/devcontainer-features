#!/bin/sh

curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64
chmod +x container-structure-test-linux-amd64
mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test
