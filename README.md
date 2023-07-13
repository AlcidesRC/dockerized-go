[![Integration Tests](https://github.com/fonil/dockerized-php-dev-env/actions/workflows/integration-tests.yml/badge.svg?branch=main)](https://github.com/fonil/dockerized-php-dev-env/actions/workflows/integration-tests.yml)

# Dockerized Go Development Environment

> A lightweight Go development environment    

[TOC]

## Summary

This repository allows to create a Docker services and/or microservices built with Go.

The Docker image is based on **golang:alpine** in order to keep images as much lightweight as possible.

### Highlights

- Unified environment to build CLI or web applications with Go.
- Lightweight: main service Docker image only requires **258.0MB**.

## Requirements

To use this repository it is required:

- [Docker](https://www.docker.com/) - An open source containerization platform.
- [Git](https://git-scm.com/) - The free and open source distributed version control system.

## Built with

| Type           | Component                                  | Description                                               |
| -------------- | ------------------------------------------ | --------------------------------------------------------- |
| Infrastructure | [Docker](https://www.docker.com/)          | Containerization platform                                 |
| Service        | [Go](https://go.dev/)                      | Build simple, secure, scalable systems with Go            |
| Miscelaneous   | [Bash](https://www.gnu.org/software/bash/) | Allows to create an interactive shell within main service |
| Miscelaneous   | [Make](https://www.gnu.org/software/make/) | Allows to execute commands defined on a _Makefile_        |

## Getting Started

Just clone the repository into your preferred path:

```bash
$ mkdir -p ~/path/to/my-new-project && cd ~/path/to/my-new-project
$ git clone git@github.com:fonil/dockerized-go-dev-env.git .
```

### Conventions

#### Application

Your application will be placed in **./src** folder.

#### Directory structure

##### The Root Directory

| Folder    | Description                                                  |
| --------- | ------------------------------------------------------------ |
| ./src     | The `src` directory contains the source code of your application. |
| ./targets | The `targets` directory contains the Makefile partials organized by task. |

##### The ./src Directory

> If you take a look to [docker-compose.yml#L14](https://github.com/fonil/dockerized-go-dev-env/blob/main/docker-compose.yml#L14) this folder is mounted as a volume into the application container.
> With this setup you are able to modify the source code of your application, within your preferred IDE, on your host and automatically have those changes in the container 😃

### Available commands

A *Makefile* is provided with some predefined commands:

```bash
~/path/to/my-new-project$ make

╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║                           .: AVAILABLE COMMANDS :.                           ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

· version                        Application: displays the Go Version
· init                           Application: initialized the Go module
· tidy                           Application: add module requirements and sum
· dependencies                   Application: list application dependencies
· test                           Application: executes the test suite
· format                         Application: fix source code format
· run                            Application: executes the main script
· compile                        Application: build the application binary file
· execute                        Application: executes the binary script
· build                          Docker: builds the service
· down                           Docker: stops the service
· up                             Docker: starts the service
· logs                           Docker: exposes the service logs
· restart                        Docker: restarts the service
· bash                           Docker: stablish a bash session into main container
```

#### Build the service

```bash
~/path/to/my-new-project$ make build
```

##### About `make build` command

It is important to use `make build` command instead of `docker-compose build` to create the Docker base image. The reason why is because the _Makefile_ command passes to `Dockerfile` your host account details, required to create an internal user into the application container with the same name, group and ids. 

This way avoids file permission conflicts on internally created files that needs to be shared with the host. 

#### Start the service

```bash
~/path/to/my-new-project$ make up
```

#### Initialize the Go module

```bash
~/path/to/my-new-project$ make init
```

#### Run the business application logic

```bash
~/path/to/my-new-project$ make run
```

#### Compile the application

```bash
~/path/to/my-new-project$ make compile
```

#### Execute the application binary file

```bash
~/path/to/my-new-project$ make execute	
```

#### Stop the service

```bash
~/path/to/my-new-project$ make down
```

#### Dealing with Code Quality

```bash
~/path/to/my-new-project$ make format
```

#### Dealing with Tests

```bash
~/path/to/my-new-project$ make test
```

## Security Vulnerabilities

Please review our security policy on how to report security vulnerabilities:

**PLEASE DON'T DISCLOSE SECURITY-RELATED ISSUES PUBLICLY**

### Supported Versions

Only the latest major version receives security fixes.

### Reporting a Vulnerability

If you discover a security vulnerability within this project, please [open an issue here](https://github.com/fonil/dockerized-go-dev-env/issues). All security vulnerabilities will be promptly addressed.

## License

The MIT License (MIT). Please see [LICENSE](./LICENSE) file for more information.
