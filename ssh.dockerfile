FROM alpine:3.20

RUN adduser -D -s /bin/sh testuser && \
    echo "testuser:changeme" | chpasswd

ENV LOG_FILE_PATH="/var/log/sshd.log" \
    PERMIT_ROOT_LOGIN="no" \
    PASSWORD_AUTHENTICATION="no" \
    PUBKEY_AUTHENTICATION="yes" \
    AUTHORIZED_KEYS_FILE_PATH="/home/testuser/.ssh/authorized_keys" \
    SSH_CONFIG_FILE="/etc/ssh/sshd_config" \
    LOG_LEVEL="DEBUG3" \
    SYS_LOG_FACILITY="AUTH" \
    CLIENT_ALIVE_INTERVAL=120 \
    CLIENT_ALIVE_COUNT_MAX=5 \
    USE_DNS="no"

RUN apk add --no-cache openssh dos2unix bash

RUN mkdir /home/testuser/.ssh && \
    chmod 700 /home/testuser/.ssh && \
    chown -R testuser:testuser /home/testuser/.ssh

COPY src/entrypoint.sh /home/testuser/app/entrypoint.sh
COPY ssh_key.pub /home/testuser/.ssh/authorized_keys

RUN chmod 600 /home/testuser/.ssh/authorized_keys && \
    chown testuser:testuser /home/testuser/.ssh/authorized_keys && \
    dos2unix /home/testuser/app/entrypoint.sh && \
    chmod 766 /home/testuser/app/entrypoint.sh && \
    chown -R testuser:testuser /home/testuser/app

EXPOSE 22

ENTRYPOINT [ "/home/testuser/app/entrypoint.sh" ]
