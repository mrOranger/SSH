FROM alpine@sha256:d9e853e87e55526f6b2917df91a2115c36dd7c696a35be12163d44e6e2a4b6bc

ARG UID=1000
ARG GID=1000

RUN addgroup -g ${GID} appgroup && \
    adduser -D -u ${UID} -G appgroup appuser

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

RUN mkdir /home/appuser/.ssh /home/appuser/app && \
    chmod -R 700 /home/appuser && \
    chown -R appuser:appgroup /home/appuser

COPY --chown=appuser:appgroup --chmod=700 [ "src/entrypoint.sh", "/home/appuser/app/entrypoint.sh" ]
COPY --chown=appuser:appgroup --chmod=600 [ "ssh_key.pub", "/home/appuser/.ssh/authorized_keys" ]

RUN dos2unix /home/appuser/app/entrypoint.sh

EXPOSE 22

ENTRYPOINT [ "/home/appuser/app/entrypoint.sh" ]
