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

# Go to /vps
log "Go to: /vps"
cd /vps

# Get configuration constants
log "Get entrypoint configuration"
source $(pwd)/vps-entrypoint.conf

# Config locale
log "Export locale: $LOCALE"
export LC_ALL=$LOCALE

# Update system
log "Starting update"
apt-get --yes update

# Upgrade system
log "Starting upgrade"
apt-get --yes upgrade

# Install dependencies
log "Starting dependencies installation"
apt-get install --yes \
    git \
    vim

# Update root password
log "Update root password"
echo "root:$ROOT_PASSWORD" | chpasswd

# Create new group
log "Create group: $USER_GROUP"
addgroup $USER_GROUP

# Create new user
log "Create user: $USER_NAME"
adduser $USER_NAME --gecos "$FULL_NAME,$ROOM_NUMBER,$WORK_PHONE,$HOME_PHONE" --ingroup "$USER_GROUP" --disabled-password

# Update new user password
log "Update $USER_NAME password"
echo "$USER_NAME:$USER_PASSWORD" | chpasswd

log "Update $HOME/$USER_NAME ownership to: $USER_NAME:$USER_GROUP"
chown -R $USER_NAME:$USER_GROUP $HOME/$USER_NAME

# ---------------
# ----- SSH -----
# ---------------

# Create .ssh repository
log "Create SSH repository"
mkdir $HOME/$USER_NAME/.ssh
chmod 700 $HOME/$USER_NAME/.ssh

# Copy SSH key
log "Copy SSH key from: /vps/ssh/id_rsa.pub"
cat /vps/ssh/id_rsa.pub >> $HOME/$USER_NAME/.ssh/authorized_keys
chmod 600 $HOME/$USER_NAME/.ssh/authorized_keys

# Copy SSH configuration
log "Copy SSH configuration from: /vps/ssh/sshd_config.conf"
cp /vps/ssh/sshd_config.conf /etc/ssh/sshd_config

# Update repository ownership
log "Update $HOME/$USER_NAME ownership to: $USER_NAME:$USER_GROUP"
chown -R $USER_NAME:$USER_GROUP $HOME/$USER_NAME

# -------------------
# ----- POSTFIX -----
# -------------------

# Install Postfix
log "Install Postfix with: $HOSTNAME"
debconf-set-selections <<< "postfix postfix/mailname string $HOSTNAME"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
apt-get install --yes mailutils

# Copy Postfix configuration
log "Copy Postfix configuration from: /vps/postfix/main.cf"
cp /vps/postfix/main.conf /etc/postfix/main.cf

# --------------------
# ----- FAIL2BAN -----
# --------------------

# Install Fail2Ban
log "Install Fail2Ban"
apt-get install --yes fail2ban

# Copy Fail2Ban configuration
log "Copy Fail2Ban configuration from: /vps/fail2ban/jail.conf"
cp /vps/fail2ban/jail.conf /etc/fail2ban/jail.local

# ---------------
# ----- UFW -----
# ---------------

# Install UFW
log "Install UFW"
apt-get install --yes ufw

log "UFW allow SSH port: $SSH_PORT"
ufw allow $SSH_PORT

# ----------------
# ----- MAIN -----
# ----------------

# Remove installation files
log "Removing installation files: /vps"
cd /
rm -r /vps

# Restart services
log "Restart services"
service postfix restart
service fail2ban restart
ufw enable
service ssh restart

# Close SSH connection
log "Closing SSH connection"
exit
