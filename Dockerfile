# syntax=docker/dockerfile:1

#-------------------------------------------------------------------------------
# STAGE: BASE
#-------------------------------------------------------------------------------

FROM --platform=linux/amd64 golang:1.20.6-alpine AS base

# Docker image context

LABEL Maintainer="Alcides Ramos <info@alcidesramos.com>"
LABEL Description="Lightweight Go development environment"

# Essentials

ENV TZ=Europe/Madrid

RUN apk add -U tzdata \
    && cp /usr/share/zoneinfo/Europe/Madrid /etc/localtime

#-------------------------------------------------------------------------------
# STAGE: DEVELOPMENT
#-------------------------------------------------------------------------------

FROM base AS development

ARG UNAME=host-user
ARG GNAME=host-group
ARG UID=1000
ARG GID=$UID

RUN apk update && apk add --no-cache \
        bash \
    && addgroup --gid $GID $GNAME \
    && adduser --shell /bin/bash --disabled-password --no-create-home --uid $UID --ingroup $GNAME $UNAME
#USER $UNAME

WORKDIR /go/src

#-------------------------------------------------------------------------------
# STAGE: BUILD
#-------------------------------------------------------------------------------

FROM base AS build

WORKDIR /go/src

COPY ./src .

RUN go mod download \
    && go mod tidy \
    && go vet -v \
    && go test -v \
    && CGO_ENABLED=0 GOOS=linux go build -v -o /go/bin/app

#-------------------------------------------------------------------------------
# STAGE: ALPINE
#-------------------------------------------------------------------------------

FROM alpine:latest AS alpine

COPY --from=build /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=build /go/bin/app /

CMD ["/app"]

#-------------------------------------------------------------------------------
# STAGE: SCRATCH
#-------------------------------------------------------------------------------

FROM scratch AS scratch

COPY --from=build /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=build /go/bin/app /

CMD ["/app"]
