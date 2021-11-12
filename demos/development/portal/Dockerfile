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

COPY        ./scripts/wait-for-it.sh /bin/
COPY        ./demos/development/portal/scripts/init.sh /bin/start.sh
RUN         chmod +x /bin/start.sh
RUN         chmod +x /bin/wait-for-it.sh

ENTRYPOINT  /bin/start.sh

