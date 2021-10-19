## Getting Started

1. Generate SSL certificates:

```
openssl req \
  -x509 \
  -newkey rsa:4096 \
  -keyout ./demos/security/tyk-ssl/certs/dashboard.tyk.local.key.pem \
  -out ./demos/security/tyk-ssl/certs/dashboard.tyk.local.cert.pem \
  -days 365 \
  -nodes \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=dashboard.tyk.local/emailAddress=zaid@tyk.io"
```

```
openssl req \
  -x509 \
  -newkey rsa:4096 \
  -keyout ./demos/security/tyk-ssl/certs/gateway.tyk.local.key.pem \
  -out ./demos/security/tyk-ssl/certs/gateway.tyk.local.cert.pem \
  -days 365 \
  -nodes \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=gateway.tyk.local/emailAddress=zaid@tyk.io"
```

2. Run docker-compose from the repo root using the following command `docker-compose -f docker-compose.yml -f demos/security/tyk-ssl/docker-compose.yml up`.
3. Navigate to [https://dashboard.tyk.local:3000](https://dashboard.tyk.local:3000) in your browser to access the Tyk Dashboard.
4. Navigate to [https://gateway.tyk.local:8080](https://gateway.tyk.local:8080) in your browser to access the Tyk Gateway.
