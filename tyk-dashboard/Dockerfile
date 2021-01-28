FROM        tykio/tyk-dashboard:latest

MAINTAINER  Zaid Albirawi

COPY        ./scripts/wait-for-it.sh /bin/
COPY        ./tyk-dashboard/scripts/init.sh /bin/start.sh
RUN         chmod +x /bin/wait-for-it.sh
RUN         chmod +x /bin/start.sh

ENTRYPOINT  /bin/start.sh
