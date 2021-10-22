FROM        golang:latest

MAINTAINER  Zaid Albirawi

WORKDIR     /go/src

ARG         GH_USERNAME
ARG         GH_TOKEN

RUN         git clone https://$GH_USERNAME:$GH_TOKEN@github.com/TykTechnologies/tyk-analytics

WORKDIR     /go/src/tyk-analytics

RUN         git submodule init

RUN         echo "deb http://us.archive.ubuntu.com/ubuntu vivid main universe" >> sudo vim /etc/apt/sources.list
RUN         apt update
RUN         apt install -y curl jq procps

COPY        ./scripts/wait-for-it.sh /bin/
COPY        ./tyk-dashboard/scripts/init.sh /bin/start.sh
RUN         chmod +x /bin/wait-for-it.sh
RUN         chmod +x /bin/start.sh

ENTRYPOINT  /bin/start.sh dev
