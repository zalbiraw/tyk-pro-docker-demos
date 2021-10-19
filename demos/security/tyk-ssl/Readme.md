## Getting Started

1. Generate a Certificate Authority:

```
openssl genrsa \
  -des3 \
  -out ./demos/security/tyk-ssl/certs/tykCA.key \
  -passout pass:topsecretpassword \
  2048
```

2. Generate root cerificate:

```
openssl req \
  -x509 \
  -new \
  -nodes \
  -key ./demos/security/tyk-ssl/certs/tykCA.key \
  -sha256 \
  -days 825 \
  -out ./demos/security/tyk-ssl/certs/tykCA.pem \
  -passin pass:topsecretpassword \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=tyk.local/emailAddress=zaid@tyk.io"
```

3. Generate SSL certificate private key:

```
openssl genrsa \
  -out ./demos/security/tyk-ssl/certs/tyk.local.key \
  2048
```

4. Generate SSL certificate certificate-signing request:

```
openssl req \
  -new \
  -key ./demos/security/tyk-ssl/certs/tyk.local.key \
  -out ./demos/security/tyk-ssl/certs/tyk.local.csr \
  -subj "/C=CA/ST=Ontario/L=London/O=Tyk/CN=tyk.local/emailAddress=zaid@tyk.io,challengePassword=topsecretpassword"
```

5. Generate SSL certificate:

```
openssl x509 \
  -req \
  -in ./demos/security/tyk-ssl/certs/tyk.local.csr \
  -CA ./demos/security/tyk-ssl/certs/tykCA.pem \
  -CAkey ./demos/security/tyk-ssl/certs/tykCA.key \
  -CAcreateserial \
  -out ./demos/security/tyk-ssl/certs/tyk.local.crt \
  -days 825 \
  -sha256 \
  -extfile ./demos/security/tyk-ssl/certs/tyk.local.ext \
  -passin pass:topsecretpassword
```

6. Add Certificate Authority to Keychain Access:

```
sudo security add-trusted-cert \
  -d \
  -r trustRoot \
  -k /Library/Keychains/System.keychain \
  ./demos/security/tyk-ssl/certs/tykCA.pem
```

7. Add `dashboard.tyk.local` and `gateway/tyk.local` to your `/etc/hosts` file.

```
127.0.0.1 gateway.tyk.local
127.0.0.1 dashboard.tyk.local
```

8. Run docker-compose from the repo root using the following command `docker-compose -f docker-compose.yml -f demos/security/tyk-ssl/docker-compose.yml up`.

9. Navigate to [https://dashboard.tyk.local:3000](https://dashboard.tyk.local:3000) in your browser to access the Tyk Dashboard.

10. Navigate to [https://gateway.tyk.local:8080](https://gateway.tyk.local:8080) in your browser to access the Tyk Gateway.
