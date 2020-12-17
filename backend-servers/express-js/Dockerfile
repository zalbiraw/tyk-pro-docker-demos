FROM        node:latest

MAINTAINER  Zaid Albirawi

RUN         mkdir -p /var/www/
COPY        ./backend-servers/express-js/src/package* /var/www/
WORKDIR     /var/www
RUN         npm i

ENTRYPOINT  node index.js
