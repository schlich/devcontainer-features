#!/bin/sh

wget https://github.com/OpenSlides/openslides-manage-service/releases/download/latest/openslides --no-clobber
chmod +x openslides
sudo mv openslides /usr/local/bin
