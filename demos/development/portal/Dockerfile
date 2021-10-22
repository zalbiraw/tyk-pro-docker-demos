FROM        golang:latest

MAINTAINER  Zaid Albirawi

WORKDIR     /go

ARG         GH_USERNAME
ARG         GH_TOKEN

RUN         mkdir -p src/github.com/TykTechnologies

WORKDIR     /go/src/github.com/TykTechnologies

RUN         git clone https://$GH_USERNAME:$GH_TOKEN@github.com/TykTechnologies/raava

WORKDIR     /go/src/github.com/TykTechnologies/raava

RUN         go build
