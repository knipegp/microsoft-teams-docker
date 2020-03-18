#!/bin/bash

# Directories for Teams caching
mkdir -p "/home/$USER/.config"
mkdir -p "/home/$USER/.pki"

UID=$(id -u) 2>/dev/null
GID=$(id -g)

# https://medium.com/faun/set-current-host-user-for-docker-container-4e521cef9ffc
# https://medium.com/@SaravSun/running-gui-applications-inside-docker-containers-83d65c0db110
docker run \
	-it \
	-e DISPLAY="$DISPLAY" \
	--mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
    --user "$UID":"$GID" \
    --workdir="/home/$USER" \
    --mount type=bind,source=/etc/group,target=/etc/group,readonly \
    --mount type=bind,source=/etc/passwd,target=/etc/passwd,readonly \
    --mount type=bind,source=/etc/shadow,target=/etc/shadow,readonly \
	--mount type=bind,source=/home/"$USER"/.config,target=/home/"$USER"/.config \
	--mount type=bind,source=/home/"$USER"/.pki,target=/home/"$USER"/.pki \
    knipegp/microsoft-teams-docker:1.0.0
