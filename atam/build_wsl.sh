#!/bin/bash

container_id=$(docker run -t -d --name AtamUbuntu atam-build:${ATAM_TAG} /bin/bash)
docker export --output=AtamUbuntu.tar $container_id
wsl.exe --import AtamUbuntu . AtamUbuntu.tar

# Run machine using: 
# wsl -d AtamUbuntu