#!/bin/bash

function ssh_server_intialization ()
{
    local PERMIT_ROOT_LOGIN="no"
    local PASSWORD_AUTHENTICATION="no"
    local PUBKEY_AUTHENTICATION="yes"
    local AUTHORIZED_KEYS_FILE_PATH="/home/testuser/.ssh/authorized_keys"
    local SSH_CONFIG_FILE="/etc/ssh/sshd_config"

    printf "PermitRootLogin ${PERMIT_ROOT_LOGIN}\n" >> ${SSH_CONFIG_FILE}
    printf "PasswordAuthentication ${PASSWORD_AUTHENTICATION}\n" >> ${SSH_CONFIG_FILE}
    printf "PubkeyAuthentication ${PUBKEY_AUTHENTICATION}\n" >> ${SSH_CONFIG_FILE}
    printf "AuthorizedKeysFile ${AUTHORIZED_KEYS_FILE_PATH}\n" >> ${SSH_CONFIG_FILE}
}

printf ">>> SSH server initialization ...\n"

ssh_server_intialization
/usr/sbin/sshd

printf ">>> SSH server initialized successfully!\n"

exec tail -f /dev/null