FROM        tykio/tyk-pump-docker-pub:v1.5

MAINTAINER  Zaid Albirawi

COPY        ./confs/pump.conf /opt/tyk-pump/pump.conf

ENTRYPOINT  /opt/tyk-pump/tyk-pump -c /opt/tyk-pump/pump.conf
