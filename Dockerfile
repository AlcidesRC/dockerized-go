# syntax=docker/dockerfile:1

#-------------------------------------------------------------------------------
# STAGE: BASE
#-------------------------------------------------------------------------------

FROM --platform=linux/amd64 golang:1.20.6-alpine AS base

# Docker image context

LABEL Maintainer="Alcides Ramos <info@alcidesramos.com>"
LABEL Description="Lightweight Go development environment"

#-------------------------------------------------------------------------------
# STAGE: DEVELOPMENT
#-------------------------------------------------------------------------------

FROM base AS development

ARG UNAME=host-user
ARG GNAME=host-group
ARG UID=1000
ARG GID=$UID

RUN addgroup --gid $GID $GNAME \
    && adduser --shell /bin/bash --disabled-password --no-create-home --uid $UID --ingroup $GNAME $UNAME
#USER $UNAME

RUN apk update && apk add --no-cache \
        bash

WORKDIR /go/src

#-------------------------------------------------------------------------------
# STAGE: PRODUCTION
#-------------------------------------------------------------------------------

FROM golang:1.20.6 AS production

WORKDIR /go/src

COPY ./src .

RUN go mod download
RUN go vet -v
RUN go test -v

RUN CGO_ENABLED=0 go build -o /go/bin/app

FROM gcr.io/distroless/static-debian11 AS distroless

COPY --from=production /go/bin/app /

CMD ["/app"]
