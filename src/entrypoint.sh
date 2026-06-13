#!/bin/bash

function ssh_server_intialization ()
{
    printf "PermitRootLogin ${PERMIT_ROOT_LOGIN}\n" >> ${SSH_CONFIG_FILE}
    printf "PasswordAuthentication ${PASSWORD_AUTHENTICATION}\n" >> ${SSH_CONFIG_FILE}
    printf "PubkeyAuthentication ${PUBKEY_AUTHENTICATION}\n" >> ${SSH_CONFIG_FILE}
    printf "AuthorizedKeysFile ${AUTHORIZED_KEYS_FILE_PATH}\n" >> ${SSH_CONFIG_FILE}
    printf "LogLevel ${LOG_LEVEL}\n" >> ${SSH_CONFIG_FILE}
    printf "SyslogFacility ${SYS_LOG_FACILITY}\n" >> ${SSH_CONFIG_FILE}
}

printf ">>> SSH server initialization ...\n"

ssh_server_intialization
ssh-keygen -A
/usr/sbin/sshd -E ${LOG_FILE_PATH}

printf ">>> SSH server initialized successfully!\n"

exec tail -f /dev/null