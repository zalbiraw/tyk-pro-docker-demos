FROM        node:latest

MAINTAINER  Zaid Albirawi

RUN         mkdir -p /var/www/
COPY        ./demos/backend-servers/express-js/src/package* /var/www/
WORKDIR     /var/www
RUN         npm i
RUN         npm install nodemon -g

ENTRYPOINT  nodemon index.js
