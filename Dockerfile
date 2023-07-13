# syntax=docker/dockerfile:1

#-------------------------------------------------------------------------------
# STAGE: BASE
#-------------------------------------------------------------------------------

FROM --platform=linux/amd64 golang:alpine AS base

# Docker image context

LABEL Maintainer="Alcides Ramos <info@alcidesramos.com>"
LABEL Description="Lightweight Go development environment"

# Arguments

ARG UNAME=host-user
ARG GNAME=host-group
ARG UID=1000
ARG GID=$UID

# Create user and group

RUN addgroup --gid $GID $GNAME \
    && adduser --shell /bin/bash --disabled-password --no-create-home --uid $UID --ingroup $GNAME $UNAME

#USER $UNAME

#-------------------------------------------------------------------------------
# STAGE: DEVELOPMENT
#-------------------------------------------------------------------------------

FROM base AS development

# Install dependencies

RUN apk update && apk add --no-cache \
        bash

# Define the working directory

WORKDIR /go/src

#-------------------------------------------------------------------------------
# STAGE: PRODUCTION
#-------------------------------------------------------------------------------

FROM base AS production

# Define the working directory

WORKDIR /go/src
