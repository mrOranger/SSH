#!/bin/bash

set -eou pipefail

function ssh_server_intialization ()
{
    : > ${LOG_FILE_PATH}
    
    printf "PermitRootLogin %s\n" ${PERMIT_ROOT_LOGIN} >> ${SSH_CONFIG_FILE}
    printf "ClientAliveInterval %s\n" ${CLIENT_ALIVE_INTERVAL} >> ${SSH_CONFIG_FILE}
    printf "ClientAliveCountMax %s\n" ${CLIENT_ALIVE_COUNT_MAX} >> ${SSH_CONFIG_FILE}
    printf "UseDNS %s\n" ${USE_DNS} >> ${SSH_CONFIG_FILE}
    printf "PasswordAuthentication %s\n" ${PASSWORD_AUTHENTICATION} >> ${SSH_CONFIG_FILE}
    printf "PubkeyAuthentication %s\n" ${PUBKEY_AUTHENTICATION} >> ${SSH_CONFIG_FILE}
    printf "AuthorizedKeysFile %s\n" ${AUTHORIZED_KEYS_FILE_PATH} >> ${SSH_CONFIG_FILE}
    printf "LogLevel %s\n" ${LOG_LEVEL} >> ${SSH_CONFIG_FILE}
    printf "SyslogFacility %s\n" ${SYS_LOG_FACILITY} >> ${SSH_CONFIG_FILE}
}

printf ">>> SSH server initialization ...\n"

ssh_server_intialization
ssh-keygen -A
/usr/sbin/sshd -E ${LOG_FILE_PATH}

printf ">>> SSH server initialized successfully!\n"

exec tail -f /dev/null
