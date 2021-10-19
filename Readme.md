# Tyk Pro Docker Demos Repo
A repo for Tyk Pro with different platforms demos.

## Requirements
1. [Tyk Pro](https://pages.tyk.io/en/sign-up-for-tyk-on-prem-licence) trial license key.
2. [Docker](https://docs.docker.com/get-docker/).

## Getting Started
1. Clone repo and navigate to the repo directory.
2. Run initalization script to initialize environment `sh scripts/init.sh` and follow the onscreen instructions to add your license key.
3. Run docker-compose using the following command `docker-compose -f docker-compose.yml up`.<br />
**NOTE:** add `-f docker-compose.local.yml` to run this on localhost.
**NOTE:** This will only run the Tyk Pro tools. If you want to run any of the other demos please check out the readme file inside their respective folders.
4. Navigate to [http://localhost:3000](http://localhost:3000) in your browser to access the Tyk Dashboard, and login with the email and password in `.env`

## Docker Compose files
- `docker-compose.local.yml`: allows you to run environment locally
- `docker-compose.dev.dashboard.yml`: allows you to run dashboard dev environment
- `docker-compose.aci.yml`: allows you to run setup in Azure Container Instance
## Platforms
- Analytics `demos/analytics`
    - **Datadog** `/datadog`

- Backend Servers `demos/backend-servers`
    - **Express.js** `/express-js`

- Deployments `demos/deployments`
    - **ACI** `/aci`

- Portal `demos/portal`
    - **Custom Templates** `/custom-templates`

- Security `demos/security`
    - **HMAC Upstream** `/hmac-upstream`
    - **Internal Auth** `/internal-auth`
    - **Tyk self-signed certs SSL Setup** `/tyk-ssl`

- Services `demos/services`
    - **ElastiCache Redis Cluster** `/elasticache-redis-cluster`
