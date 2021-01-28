FROM        tykio/tyk-dashboard:latest

MAINTAINER  Zaid Albirawi

RUN         echo "deb http://us.archive.ubuntu.com/ubuntu vivid main universe" >> sudo vim /etc/apt/sources.list
RUN         apt update
RUN         apt install -y jq procps

COPY        ./scripts/wait-for-it.sh /bin/
COPY        ./tyk-dashboard/scripts/init.sh /bin/start.sh
RUN         chmod +x /bin/wait-for-it.sh
RUN         chmod +x /bin/start.sh

ENTRYPOINT  /bin/start.sh
