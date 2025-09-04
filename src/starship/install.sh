#!/usr/bin/env bash

curl -sS https://starship.rs/install.sh | sh -s -- -y

mkdir -p /usr/local/share/.config
echo "character = { $CHARACTER }" >> /usr/local/share/.config/starship.toml
