## Getting Started
1. Run docker-compose from the repo root using the following command `docker-compose -f docker-compose.yml -f demos/security/internal-auth/docker-compose.yml up`.
2. Navigate to [http://localhost:3000](http://localhost:3000) in your browser to access the Tyk Dashboard.
3. Navigate to [http://localhost:3030/login](http://localhost:3030/login) in your browser to access the internal API.
4. Send a POST request to [http://127.0.0.1:8080/token/get](http://127.0.0.1:8080/token/get) to retrieve auth token.
5. Send a GET request to [http://127.0.0.1:8080/api/internal/get](http://127.0.0.1:8080/api/internal/get) using the auth token as the `Authorization` header value. Tyk will then replace the auth token with the JWT in the request header.

### Notes
- If you look up the auth token in the dashboard under the Keys section you will find that the JWT is stored as metadata for that auth token.

- You can find the configuration to replace the `Authorization` header with the JWT under APIs -> My Internal API -> Endpoint Designer -> GLOBAL VERSION SETTINGS

- You can find the configuration to login into your internal auth and generate a Tyk key while storing the retrieved information from your login as metadata under that key under APIs -> Login -> Endpoint Designer -> POST :/token/get
