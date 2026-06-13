FROM alpine:3.20

RUN adduser -D -s /bin/sh testuser

RUN apk add --no-cache openssh

RUN mkdir /home/testuser/.ssh && \
    chmod 766 /home/testuser/.ssh && \
    chown -R testuser:testuser /home/testuser/.ssh

COPY src/entrypoint.sh /home/testuser/app/entrypoint.sh
COPY ssh_key /home/testuser/.ssh/authorized_keys

RUN chmod +x /home/testuser/app/entrypoint.sh && \
    chown -R testuser:testuser /home/testuser/app

EXPOSE 22

ENTRYPOINT [ "/home/testuser/app/entrypoint.sh" ]
