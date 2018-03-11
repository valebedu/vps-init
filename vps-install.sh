#!/usr/bin/env bash

# ---------------------
# ----- FUNCTIONS -----
# ---------------------

function log() {
    prefix=""
    suffix=""
    line=""

    for (( i = 0; i < ${#1}; i++ )); do
        line+="-"
    done

    if [[ $2 == "1" ]]; then
        prefix="\e[1m\e[31"
        suffix="\e[0m"
    fi

    echo -e ""
    echo -e "$prefix$line$suffix"
    echo -e "$prefix$1$suffix"
    echo -e "$prefix$line$suffix"
    echo -e ""
}

# ----------------
# ----- MAIN -----
# ----------------

# Get configuration constants
log "Get install configuration"
source $(pwd)/vps-install.conf

# Copy setup files to remote
log "Copy files to: root@$REMOTE_ADDRESS:/vps"
scp -r $(pwd)/vps root@$REMOTE_ADDRESS:/vps

# Exec entrypoint on remote
log "Exec through SSH: root@$REMOTE_ADDRESS/vps/vps-entrypoint.sh"
ssh root@$REMOTE_ADDRESS "exec /vps/vps-entrypoint.sh"
