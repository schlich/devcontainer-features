#!/bin/sh

wget https://github.com/OpenSlides/openslides-manage-service/releases/download/latest/openslides --no-clobber
chmod +x openslides
sudo mv openslides /usr/local/bin


if [ ${INCLUDE_TESTING_TOOL} == "true" ]; then
    wget https://github.com/OpenSlides/openslides-performance/releases/download/v0.0.2/openslides-performance_0.0.2_Linux_x86_64.tar.gz --no-clobber
    tar -xvf openslides-performance_0.0.2_Linux_x86_64.tar.gz
    chmod +x openslides-performance
    sudo mv openslides-performance /usr/local/bin
fi