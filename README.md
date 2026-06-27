# SSH Server

This project is a dummy SSH user, made for testing bash script requiring SSH connection. The project is completely made
using Docker. For any updates feel free to change the configuration. At the moment the project has been tested only in
MacOS and Linux (Ubuntu) environments.

## Project Structure

The project is composed of the following critical files:

```
ssh-server/
├── ssh.dockerfile
├── .env.development
├── docker-compose.ssh.yaml
├── start.sh
├── src/
│   └── entrypoint.sh
└── logs/
    ├── sshd.log
    └── build.log
```

- [`ssh.dockerfile`](./ssh.dockerfile) Dockerfile containing the image definition, is based on Alpine.
- [`.env.development`](./.env.development) Environment variables used to configure the SSH server, changes them on you need.
- [`docker-compose.ssh.yaml`](./docker-compose.ssh.yaml) Compose script to start the project
- [`start.sh`](./start.sh) Bash script to build and start the server
- [`src/entrypoint.sh`](./src/entrypoint.sh) Bash script used to initialize the SSH server
- [`logs/sshd.log`](./logs/sshd.log) Output log of the SSH server
- [`logs/build.log`](./logs/build.log) Output of the build process

## Requirements

Before start the server, you have to generate an SSH key inside the current folder. This is a need phase, since the
container must include the file `authorized_hosts` for accepting SSH connection from outside the container. The file
`authorized_hosts` is just a copy of the public key `ssh_key.pub` generated through the command:

```bash
ssh-keygen -t ed25519 -C "docker-ssh" -f ./ssh_key
```

Moreover, connecting to the SSH server, requires the private key `ssh_key` generated using the previous command.

## Startup

Starting the server requires first to copy the file `.env.development` inside a `.env`, updating the missing environment
variables. Next you can run the following docker command:

```sh
docker compose --file=docker-compose.yaml up --progress=plain --build --detach
```

If everything is okay, you can test the connection throught the command:

```bash
ssh -v -i ./ssh_key -p 2000 testuser@localhost
```