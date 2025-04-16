#!/bin/bash

container_id=$(docker run -t -d --name OpSysUbuntu opsys-build:${OP_SYS_TAG} /bin/bash)
docker export --output=OpSysUbuntu.tar $container_id
wsl.exe --import OpSysUbuntu . OpSysUbuntu.tar

# Run machine using: 
# wsl -d OpSysUbuntu --user student